# Image Docker sur laquelle est basée la nouvelle image que nous allons créer
FROM postgres:15
# Utilisateur "administrateur" du système de gestion de base de données
ENV POSTGRE_USER postgres
# Mot de passe (complexe, s'il vous plait) de l'utilisateur administrateur
ENV POSTGRES_PASSWORD B%Z8D§ERF7!
# Création d'une base de données avec un nom prédéfini : "society"
ENV POSTGRES_DB carpooling
# Copie du fichier de création de BDD dans l'image
# ce script sera démarré automatiquement au lancement du conteneur
COPY carpooling-postgre.sql /docker-entrypoint-initdb.d/

#docker build -t <nom> .
 
#docker run -p 4152:5432 --name orders-exercice order