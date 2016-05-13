include Padrino::Helpers
module RssHelpers
  def rss_noticias
    # Noticias de Alicante
    entradas = rss_noticias_alicante
    entradas.concat(rss_noticias_valencia)
    entradas.concat(rss_noticias_castellon)
    entradas.sort! {|a,b| a.published <=> b.published}
    entradas.reverse!
  end
  def rss_noticias_alicante
    url_ua = 'http://iei.ua.es/es/noticias.xml'
    rss_read_feed(url_ua, 'Alicante')
  end
  def rss_noticias_valencia
    url_uv = 'http://iei.uv.es/feed/'
    rss_read_feed(url_uv, 'Valencia')
  end
  def rss_noticias_castellon
    url_uji = 'http://iei.uji.es/feed.php'
    rss_read_feed(url_uji, 'Castellón')
  end

  def rss_read_feed(url, productor)
    Feedjira::Feed.add_common_feed_entry_element('generator')
    feed = Feedjira::Feed.fetch_and_parse url
    feed.entries.map {|entry| entry.generator=productor}
    feed.entries
  end
  def page_title
    current_page.data.title || data.site.titulo
  end
  def pagina_destino
    pagina_actual = current_page.destination_path
    pagina_actual.split("/").first
  end
  def breadcrumb_link(elemento, path)
    content_tag(:a, elemento.gsub(/-/, ' '), href: path)
  end
  def breadcrumb_item(elemento,path, clase)
    content_tag(:li, breadcrumb_link(elemento, path), class: clase)
  end
  def breadcrumbs_text(text)
    # Borra la parte final si contiene .html
    I18n.t('breadcrumbs.'+text)
  end
  def breadcrumbs_mio
    caminos = current_page.url.split("/")
    path = ""
    list = caminos[1..caminos.length-1].map.with_index do | camino,index |
      path += "/"+camino
      clase = nil
      texto =  if caminos.length == 2
                  clase = "current"
                  breadcrumbs_text(camino)
               else
                 begin
                   if index == caminos.length-2
                     clase = "current"
                     truncate(current_page.data.title)
                   else
                     breadcrumbs_i18n_text(camino)
                   end
                 end
               end
      breadcrumb_item(texto,path, clase)
    end
    content_tag(:nav, list, class: "breadcrumbs", role: "menubar") 
  end
  # Crea un hash con un array de investigadores de las tres sedes
  def investigadores
    # Crea un hash que contiene arrays
    investigadores = Hash.new {|hash, key| hash[key]=[]}
    # Añade el contenido de investigadores_ua
    investigadores.concat(add_investigadores_ua)
    #investigadores.sort! {|a, b| a.<=>b}
  end
  def add_investigadores_ua
    h = Hash.new {|hash, key| hash[key]=[]}
    data.investigadores_ua.each do |investigador|
      apellidos_nombre = "#{investigador.apellidos},#{investigador.nombre}"
      h[apellidos_nombre].push investigador
    end
    h
  end
end
