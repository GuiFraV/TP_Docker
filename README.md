Etape 1 :
2 containers :

- HTTP : 1 container avec un serveur HTTP qui écoute sur le port 8080
- SCRIPT : 1 container avec un interpréteur PHP (plus le protocole FPM pour NGINX)

Une page index.php qui lorsqu'elle est appelée exécute la fonction php_info()

Test de validité de l'exercice : avec un navigateur voir le résultat de l'exécution du php_info()

Etape 2 :
3 containers :

- HTTP : 1 container avec un serveur HTTP qui écoute sur le port 8080
- SCRIPT : 1 container avec un interpréteur PHP (plus le protocole FPM pour NGINX)
- DATA : 1 container avec un serveur de base données SQL (MariaDB, MySQL, PostgreSQL, ...)

Une page test_bdd.php qui lorsqu'elle est appelée va executer 2 requêtes CRUD (Request : lecture, Create Update Delete : écriture) au minimum sur le serveur SQL : 1 lecture et 1 écriture

Test de validité de l'exercice : avec un navigateur voir le résultat de l'exécution de la page en retournant un résultat différent et dépendant du contenu de la base de données à chaque refresh de la page

Etape 3 :
3 containers :

- HTTP : 1 container avec un serveur HTTP qui écoute sur le port 8080
- SCRIPT : 1 container avec un interpréteur PHP (plus le protocole FPM pour NGINX)
- DATA : 1 container avec un serveur de base données SQL (MariaDB, MySQL, PostgreSQL, ...)

Remplacer la/les pages PHP simples par un package Wordpress complet.

Test de validité de l'exercice : avec un navigateur voir l'interface d'admin/installation de Wordpress afin de finaliser l'installation de celui-ci

Etape 4 :
Convertir la configuration de l'étape 3 en Docker Compose

Test de validité de l'exercice : identique à l'étape 3
