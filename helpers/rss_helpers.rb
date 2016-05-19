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

  def es_pagina_activa(nombre)
    "active" if nombre == current_page.url.split("/").last
  end

  def page_title
    current_page.data.title || data.site.titulo
  end
end
