include Padrino::Helpers
module MiddlemanHelpers
  # Manipulación de datos de las fuentes externas
  def noticias
    # Noticias de Alicante
    entradas = rss_noticias_alicante
    entradas.concat(rss_noticias_valencia)
    entradas.concat(rss_noticias_castellon)
    entradas.sort! {|a,b| a.published <=> b.published}
    entradas.reverse!
  end
  def es_pagina_activa(nombre)
    "active" if nombre == current_page.url.split("/").last
  end

  def page_title
    current_page.data.title || data.site.titulo
  end
end
