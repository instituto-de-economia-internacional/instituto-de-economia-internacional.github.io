mv data/*.json old-data/
wget iei.ua.es/es/investigadores-json.json
mv investigadores-json.json data/investigadores_ua.json
wget http://iei.uv.es/investigadores.php
mv investigadores.php data/investigadores_uva.json
wget http://iei.uji.es/investigadores.php
mv investigadores.php data/investigadores_uji.json

