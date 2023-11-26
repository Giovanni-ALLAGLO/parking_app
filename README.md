# parking_application

Application mobile permettant de recommander un parking à un conducteur se rendant à Lille.

## Fonctionalités

- Page d'acceuil avec un écran d'animation
- Recuperation des données depuis le [portail Open Data de la MEL](https://opendata.lillemetropole.fr/explore/dataset/disponibilite-parkings/information/)
avec une requête de type `http`
- Affichage dans un écran defilant des resultats de parkings en fonction de l'emplacement de l'utilisateur.
- Indicateurs colorés pour montrer l'etat d'occupation du parking (vert : très disponible, orange : moyennement , rouge : peu disponible )
- Mise en Favoris grâce à un appui long sur un parking
- Calcul de la distance euclidienne entre la localisation et le parking choisi
- Utilisation du package de google maps afin d'afficher la carte et l'itinéraire
