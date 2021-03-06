activate :directory_indexes
activate :autoprefixer

set :relative_links, true
set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "assets/images"
set :fonts_dir, "assets/fonts"
set :layout, "layouts/application"

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Imagen - Optimizacion

configure :development do
  activate :livereload
end

configure :build do
  activate :relative_assets
end
activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.build_before = true
  deploy.build_before = true
  deploy.branch = 'master'
end


activate :breadcrumbs, separator: nil, wrapper: :li
