#!/bin/bash

# Créer le réseau Docker si ce n'est pas déjà fait
docker network ls | grep -q reseau || docker network create reseau

# Lancer le conteneur MySQL
docker run -d --network reseau --name db -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=test_db -v db_data:/var/lib/mysql mysql:8.0

# Lancer le conteneur PHP-FPM avec l'extension mysqli
docker run -d --network reseau --name script -v $(pwd)/app:/app php:8.3.7-fpm bash -c "docker-php-ext-install mysqli && docker-php-ext-enable mysqli && php-fpm"

# Lancer le conteneur Nginx avec la configuration modifiée
docker run -p 8080:80 -d --name http -v $(pwd)/app:/app -v $(pwd)/default.conf:/etc/nginx/conf.d/default.conf --network reseau nginx:1.25

# Recharger la configuration de Nginx
docker exec -it http nginx -s reload
