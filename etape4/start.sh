#!/bin/bash

# Créer le dossier app s'il n'existe pas
if [ ! -d "app" ]; then
  mkdir app
fi

# Télécharger WordPress
wget https://wordpress.org/latest.tar.gz -O wordpress.tar.gz
tar -xzf wordpress.tar.gz -C app
rm wordpress.tar.gz

# Créer le fichier de configuration Nginx
cat <<EOL > default.conf
server {
    listen 80;
    server_name localhost;

    root /app/wordpress;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass script:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOL

# Lancer Docker Compose
docker-compose up -d