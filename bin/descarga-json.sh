mv data/*.json old-data/
wget http://iei.ua.es/es/api/investigadores-json.json
mv investigadores-json.json ../data/investigadores_ua.json
wget http://iei.uv.es/investigadores.php
mv investigadores.php ../data/investigadores_uva.json
wget http://iei.uji.es/investigadores.php
mv investigadores.php ../data/investigadores_uji.json
wget http://iei.ua.es/es/api/noticias-json.json
mv noticias-json.json ../data/noticias_ua.json
wget http://iei.uji.es/noticias.php
mv noticias.php ../data/noticias_uji.json
wget http://iei.uv.es/noticias.php
mv noticias.php ../data/noticias_uva.json
