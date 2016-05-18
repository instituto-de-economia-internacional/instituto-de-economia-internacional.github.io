include Padrino::Helpers
module RssHelpers
  # Manipulación de datos de las fuentes externas
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
  def investigadores_institutos
    # Crea un hash que contiene arrays
    investigadores = Hash.new 
    investigadores["Alicante"] = investigadores_alicante
    # Añade el contenido de investigadores de Castellon
    investigadores["Castellón"] = investigadores_castellon
    #investigadores.sort_by {|h| h[:apellidosynombre]}
    investigadores
  end
  def investigadores_alicante
    investigadores = []
    data.investigadores_ua.each do |investigador_ua|
      investigador = Hash.new
      investigador[:apellidosynombre] = "#{investigador_ua.apellidos}, #{investigador_ua.nombre}"
      investigador[:foto] = investigador_ua.foto
      investigador[:paginapersonal] = investigador_ua.orcid
      investigador[:rol] = investigador_ua.rol
      investigador[:sede] = investigador_ua.sede
      investigadores << investigador
    end
    investigadores
  end
  def investigadores_castellon
    investigadores = []
    data.investigadores_uji.each do |investigador_uji|
      investigador = Hash.new
      investigador[:apellidosynombre] = investigador_uji.nombre
      investigador[:foto] = investigador_uji.foto
      if investigador_uji.foto == "http://iei.uji.es/images/personal/foto.png" || investigador_uji.foto == "http://iei.uji.es/images/personal/nodisponible48.jpg"
        investigador[:foto] = ""
      end
      investigador[:paginapersonal] = nil
      investigador[:paginapersonal] = investigador_uji.orcid unless investigador_uji.orcid == ""
      investigador[:paginapersonal] = "http://orcid.org/#{investigador_uji.orcid}" unless investigador_uji.orcid[0,4] == 'http' || investigador_uji.orcid == ""
      investigador[:rol] = investigador_uji.rol
      investigador[:sede] = "Castellón"
      investigadores << investigador
    end
    investigadores
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
end
