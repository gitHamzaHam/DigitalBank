# Application de Gestion des Prêts Bancaires avec Prédiction du Risque

## Présentation du projet

Ce projet consiste à développer une application web Java EE permettant la gestion complète des clients, des prêts bancaires et des utilisateurs, intégrant un module d'intelligence artificielle pour la prédiction du risque de défaut de prêt.

L'objectif est de simuler un système bancaire professionnel en remplaçant une gestion manuelle (Excel) par une plateforme sécurisée, centralisée et enrichie par des outils d'aide à la décision.

---

## Architecture globale

L'application repose sur une architecture multi-tiers :

- Interface utilisateur web (JSP)
- Serveur applicatif Java EE (Tomcat)
- Base de données relationnelle MySQL
- Serveur d'intelligence artificielle Flask (Python)

Le serveur JEE communique avec le serveur Flask via des requêtes HTTP REST (JSON).

---

## Technologies utilisées

### Backend

- Java EE (Servlets, JSP, JSTL)
- Apache Tomcat 9
- JDBC
- MySQL
- Pattern MVC
- Filtres de sécurité (AuthFilter)

### Intelligence artificielle

- Python 3
- Flask
- Scikit-learn
- Joblib
- Modèle Random Forest
- Régression logistique

### Frontend

- JSP / HTML / CSS / JavaScript
- Tailwind CSS
- Lucide Icons
- Chart.js
- Dashboard interactif
- Pagination dynamique

### Outils

- IntelliJ IDEA
- Git / GitHub
- Postman / CURL

---

## Structure du projet

```
DigitalBank/
│
├── backend/
│   └── src/
│       ├── main/java/com/banque/
│       │   ├── model/          Entités métier (Client, Pret)
│       │   ├── web/            Contrôleurs (Servlets)
│       │   ├── service/        Logique métier et appel Flask
│       │   └── util/           Utilitaires (DBConnection)
│       │
│       └── main/webapp/
│           ├── _layout.jsp     Fragment partagé (navbar, CDN)
│           ├── index.jsp       Page de connexion
│           ├── menu.jsp        Tableau de bord
│           ├── clients.jsp     Liste des clients
│           ├── prets.jsp       Liste et analyse des prêts
│           ├── ajouterClient.jsp
│           ├── editerClient.jsp
│           └── resultat.jsp    Résultat de la prédiction IA
│
├── ai/                         Serveur IA (Flask)
│   ├── app.py
│   ├── model.pkl
│   ├── requirements.txt
│
├── .gitignore
└── README.md
```

---

## Gestion des rôles

Un rôle administrateur est défini avec accès complet à :

- La gestion des clients et des prêts
- L'évaluation du risque par l'IA
- Le tableau de bord analytique

L'accès est sécurisé par :

- Authentification (login / mot de passe)
- Sessions HTTP gérées côté serveur
- Redirection automatique si session absente

---

## Fonctionnalités principales

### Clients

- Ajout, modification et suppression
- Recherche par identifiant et par ville
- Consultation des prêts associés
- Pagination dynamique

### Prêts

- CRUD complet
- Association à un client
- Filtrage par type (immobilier / automobile)
- Calcul du coût total et du niveau de risque du taux
- Évaluation du risque via l'IA

### Prédiction du risque

- Appel à l'API Flask au moment de la demande
- Retour d'une classification : risque faible ou risque élevé
- Affichage du résultat avec recommandation contextuelle

### Dashboard

- Nombre total de clients
- Nombre total de prêts
- Répartition immobilier / automobile
- Taux moyen par type
- Graphiques interactifs (Chart.js)
- Accès rapide aux fonctionnalités principales

---

## Lancement du projet

### Base de données

1. Créer la base MySQL :

```sql
CREATE DATABASE gestion_prets;
```

2. Exécuter les scripts SQL (clients, prets, utilisateurs)
3. Configurer la connexion dans `DBConnection.java` :

```java
private static final String URL      = "jdbc:mysql://localhost:3306/gestion_prets";
private static final String USER     = "root";
private static final String PASSWORD = "votre_mot_de_passe";
```

### Lancer le serveur Flask

```bash
cd ai
pip install -r requirements.txt
python app.py
```

API disponible sur :

```
http://localhost:5000/predict
```

### Lancer l'application JEE

1. Importer le projet dans IntelliJ IDEA
2. Configurer Apache Tomcat 9
3. Déployer et accéder à :

```
http://localhost:8080/ProjetGestionprets/
```

---

## Communication JEE – Flask

Le serveur JEE envoie les données du prêt au format JSON (revenu, mensualité, durée, taux, type).

Le serveur Flask retourne :

- Une classification du risque (faible ou élevé)
- Une interprétation affichée à l'administrateur

Le résultat est affiché sur une page dédiée avec une recommandation contextuelle.

---

## Perspectives d'amélioration

- Comparaison entre régression logistique et réseau de neurones
- Ajout de graphiques statistiques avancés (répartition par ville, évolution temporelle)
- Mise en cache des prédictions IA
- Hachage des mots de passe (BCrypt)
- Requêtes préparées (PreparedStatement) pour prévenir les injections SQL
- Conteneurisation avec Docker

---

## Auteur

**Hamza El Hamidine**  
Étudiant en informatique — ISGA  
Projet académique : Gestion bancaire et intelligence artificielle
