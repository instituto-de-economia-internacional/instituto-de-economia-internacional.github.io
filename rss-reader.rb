require 'feedjira'
require 'sanitize'

url_ua = 'http://iei.ua.es/es/noticias.xml'
url_uv = 'http://iei.uv.es/feed/'

Feedjira::Feed.add_common_feed_entry_element('generator')
feed_ua = Feedjira::Feed.fetch_and_parse url_ua
feed_ua.entries.map {|entry| entry.generator='UA'}

feed_uv = Feedjira::Feed.fetch_and_parse url_uv
feed_uv.entries.map {|entry| entry.generator='UV'}

entradas = feed_ua.entries
#entradas.zip(feed_uv.entries).flatten.compact
entradas.concat(feed_uv.entries)

entradas.sort! {|a,b| a.published <=> b.published}
entradas.reverse!

entradas.each do |entrada|
  puts "Generador: #{entrada.generator} Fecha: #{entrada.published} Titulo: #{entrada.title} "
  puts "Url: #{entrada.url} Sumario: #{Sanitize.clean(entrada.content)}"
  puts "--------------------------------------------------------------------------------------------"
end

puts entradas.first
