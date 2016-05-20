mv data/*.json old-data/
wget iei.ua.es/es/investigadores-json.json
mv investigadores-json.json data/investigadores_ua.json
wget http://iei.uv.es/investigadores.php
mv investigadores.php data/investigadores_uva.json
wget http://iei.uji.es/investigadores.php
mv investigadores.php data/investigadores_uji.json
wget iei.ua.es/es/noticias-json.json
mv noticias-json.json data/noticias_ua.json
