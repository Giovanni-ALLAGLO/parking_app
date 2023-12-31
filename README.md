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


## Ecrans

`splash_page.dart` ecran d'accueil

`myHomePage.dart` écran sur lequel se trouve la liste des parking (`parkingList.dart`) et la liste des favoris(`favoris.dart`).

`mapView.dart` carte de géolocalisation et calcul de distance.

## Outils

- Ressources de open data de la MEL
- Utilisation des SharedPreferences pour stocker les favoris
- API Google MAPS pour les données GPS

## Pistes d'amélioration

Pouvoir choisir un lieu autre que son emplacement actuelle afin de trouver des parkings proches.
