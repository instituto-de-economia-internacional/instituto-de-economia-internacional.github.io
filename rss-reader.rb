require 'rss'
require 'open-uri'
require 'feedjira'

url = 'http://iei.ua.es/es/noticias.xml'
open(url) do |rss|
  feed = RSS::Parser.parse(rss, do_validate=false, ignore_unknown_element=false)
  #puts "Title: #{feed}"
  feed.items.each do |item|
    #puts item.title.content
  end
end


url = 'http://iei.ua.es/es/noticias.xml'
feed = Feedjira::Feed.fetch_and_parse url
puts feed.url
puts '======================================================================='
feed.entries.each do |entry|
  puts "Fecha: #{entry.updated.strftime('%d/%m/%Y')} #{entry.title}"
end
