#!/bin/bash

# Variables
NETWORK_NAME="reseau"
PHP_CONTAINER_NAME="script"
NGINX_CONTAINER_NAME="http"
PHP_IMAGE="php:8.3.7-fpm"
NGINX_IMAGE="nginx:1.25"
HOST_PORT=8080
CONTAINER_PORT=80
APP_DIR=$(pwd)

# Créer le réseau Docker
docker network create $NETWORK_NAME

# Lancer le conteneur PHP-FPM
docker container run -d --network $NETWORK_NAME --name $PHP_CONTAINER_NAME -v $APP_DIR:/app $PHP_IMAGE

# Lancer le conteneur Nginx avec la configuration modifiée
docker container run -p $HOST_PORT:$CONTAINER_PORT -d --name $NGINX_CONTAINER_NAME -v $APP_DIR:/app -v $APP_DIR/default.conf:/etc/nginx/conf.d/default.conf --network $NETWORK_NAME $NGINX_IMAGE

# Vérifier que le fichier default.conf est correctement copié
echo "Vérification de la configuration Nginx:"
docker exec -it $NGINX_CONTAINER_NAME cat /etc/nginx/conf.d/default.conf

# Vérifier que le fichier index.php est présent dans le répertoire /app
echo "Vérification des fichiers dans /app:"
docker exec -it $NGINX_CONTAINER_NAME ls /app

# Recharger la configuration de Nginx
echo "Rechargement de la configuration Nginx:"
docker exec -it $NGINX_CONTAINER_NAME nginx -s reload

# Redémarrer le service PHP-FPM
echo "Redémarrage du service PHP-FPM:"
docker exec -it $PHP_CONTAINER_NAME service php8.3-fpm restart

echo "Configuration terminée. Accédez à http://localhost:$HOST_PORT pour voir la page phpinfo()."
