include Padrino::Helpers
module RssHelpers
  def rss_noticias
    # Noticias de Alicante
    entradas = rss_noticias_alicante
    entradas.concat(rss_noticias_valencia)
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
  end

  def rss_read_feed(url, productor)
    Feedjira::Feed.add_common_feed_entry_element('generator')
    feed = Feedjira::Feed.fetch_and_parse url
    feed.entries.map {|entry| entry.generator=productor}
    feed.entries
  end
end
