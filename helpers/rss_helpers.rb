include Padrino::Helpers
module RssHelpers
  def rss_noticias
    # Noticias de Alicante
    rss_noticias_alicante
  end
  def rss_noticias_alicante
   rss_read_feed(data.fuentesrss.noticias.ua.first)
  end
  def rss_read_feed(url)
    Feedjira::Feed.fetch_and_parse url
  end
end
