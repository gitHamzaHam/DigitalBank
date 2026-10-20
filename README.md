# DigitalBank — Plateforme de Gestion de Prêts Bancaires

**Auteur :** Hamza El Hamidine  
**Institution :** Institut Supérieur de Gestion et d'Administration (ISGA)  
**Dépôt :** https://github.com/gitHamzaHam/DigitalBank  
**Statut :** Projet académique — en développement actif

---

## Présentation du projet

DigitalBank est une application web de gestion bancaire développée dans le cadre d'un projet académique à l'ISGA. Elle simule une interface d'administration interne pour une banque, permettant de gérer les dossiers clients, d'analyser les prêts accordés, et d'obtenir des prédictions de solvabilité générées par un modèle de machine learning.

L'objectif du projet est de couvrir l'ensemble du cycle d'une demande de prêt, depuis l'enregistrement du profil client jusqu'à l'évaluation automatisée du risque de défaut de remboursement. L'application a été conçue pour refléter les pratiques réelles des systèmes d'information bancaires, tout en restant accessible à un niveau étudiant avancé.

---

## Fonctionnalités principales

**Authentification et sécurité**

L'accès à l'application est protégé par un système de connexion basé sur des sessions Java EE. Seuls les administrateurs dont les identifiants sont enregistrés en base de données peuvent accéder au tableau de bord. Les sessions sont gérées côté serveur, et toute tentative d'accès direct aux pages internes sans authentification préalable est redirigée vers la page de connexion.

**Tableau de bord**

Le tableau de bord centralise les statistiques clés du portefeuille bancaire : nombre total de clients enregistrés, nombre total de prêts actifs, répartition entre les prêts immobiliers et automobiles, et taux d'intérêt moyens par catégorie. Ces données sont visualisées sous forme de graphiques interactifs (graphique en anneau et graphique à barres horizontales) générés par la bibliothèque Chart.js.

**Gestion des clients**

L'administrateur peut consulter la liste complète des clients, filtrer par identifiant ou par ville, ajouter de nouveaux dossiers clients avec leurs informations personnelles et financières, modifier les informations existantes, et supprimer un dossier avec confirmation. Chaque client est caractérisé par sa ville de résidence, son code postal et son revenu mensuel déclaré.

**Analyse des prêts**

La liste des prêts donne une vue d'ensemble de tous les financements accordés. Pour chaque prêt, on dispose de la mensualité de remboursement, du coût total sur la durée complète du crédit, de la durée en mois, du type de prêt (immobilier ou automobile), et du taux d'intérêt assorti d'un indicateur de niveau de risque (faible, modéré ou élevé). Des filtres permettent de rechercher par identifiant de prêt, identifiant client ou type de prêt.

**Prédiction de solvabilité par intelligence artificielle**

Chaque dossier de prêt peut faire l'objet d'une analyse de risque en temps réel. En cliquant sur le bouton de prédiction, l'application envoie les données du client (revenu, mensualité, durée, taux, type de prêt) à une API Python développée séparément. Cette API utilise un modèle de machine learning entraîné sur des historiques de remboursement pour classer le client comme solvable (risque faible) ou à risque (risque élevé). Le résultat est affiché sur une page dédiée avec une recommandation contextuelle.

---

## Architecture technique

Le projet est organisé en deux modules indépendants hébergés dans le même dépôt Git :

**Module Backend (Java EE)**

Ce module constitue l'application web principale. Il repose sur une architecture MVC classique où les Servlets Java jouent le rôle de contrôleurs, les JSP servent de vues, et les classes du package modèle encapsulent les données métier.

**Module IA (Python)**

Ce module est une API REST développée avec le micro-framework Flask. Il expose un endpoint qui reçoit les caractéristiques d'un dossier de prêt, les fait passer à travers un modèle de classification entraîné avec Scikit-learn, et retourne la prédiction de risque au module Java.

---

## Structure du dépôt

```
DigitalBank/
|
|-- backend/                        Module Java EE (application principale)
|   |
|   |-- src/main/
|   |   |-- java/com/banque/
|   |   |   |-- model/              Classes métier (Client, Pret)
|   |   |   |-- service/            Logique métier et appels à l'API IA
|   |   |   |-- util/               Utilitaires (connexion BDD)
|   |   |   |-- web/                Servlets (contrôleurs HTTP)
|   |   |       |-- LoginServlet.java
|   |   |       |-- MenuServlet.java
|   |   |       |-- ListeClientsServlet.java
|   |   |       |-- ListePretsServlet.java
|   |   |       |-- SauvegarderClientServlet.java
|   |   |       |-- SupprimerClientServlet.java
|   |   |       |-- PredictionServlet.java
|   |   |
|   |   |-- webapp/                 Vues JSP et ressources web
|   |       |-- _layout.jsp         Fragment partagé (navbar, CDN)
|   |       |-- index.jsp           Page de connexion
|   |       |-- menu.jsp            Tableau de bord
|   |       |-- clients.jsp         Liste des clients
|   |       |-- prets.jsp           Liste et analyse des prêts
|   |       |-- ajouterClient.jsp   Formulaire d'ajout
|   |       |-- editerClient.jsp    Formulaire de modification
|   |       |-- resultat.jsp        Résultat de la prédiction IA
|   |
|   |-- pom.xml                     Configuration Maven
|
|-- ai/                             Module Python (API de prédiction)
|   |-- app.py                      Serveur Flask et endpoint de prédiction
|   |-- model.pkl                   Modèle de machine learning sérialisé
|   |-- requirements.txt            Dépendances Python
|
|-- .gitignore
|-- README.md
```

---

## Technologies utilisées

**Côté serveur (Backend Java)**

| Technologie         | Version     | Rôle                                      |
|---------------------|-------------|-------------------------------------------|
| Java                | JDK 11+     | Langage principal du backend              |
| Java EE / Jakarta   | Servlet 4.0 | Framework web (Servlets, JSP, JSTL)       |
| Apache Tomcat       | 9.x         | Serveur d'application                     |
| MySQL               | 8.x         | Base de données relationnelle             |
| Maven               | 3.x         | Gestion des dépendances et build          |
| JDBC                | Standard    | Connexion à la base de données            |

**Côté client (Frontend)**

| Technologie         | Version     | Rôle                                      |
|---------------------|-------------|-------------------------------------------|
| Tailwind CSS        | CDN 3.x     | Framework CSS utilitaire                  |
| Lucide Icons        | CDN latest  | Bibliothèque d'icônes SVG                 |
| Chart.js            | CDN latest  | Visualisation de données (graphiques)     |
| Plus Jakarta Sans   | Google Fonts| Police de caractères principale           |

**Côté IA (API Python)**

| Technologie         | Version     | Rôle                                      |
|---------------------|-------------|-------------------------------------------|
| Python              | 3.9+        | Langage du module IA                      |
| Flask               | 2.x         | Serveur API REST léger                    |
| Scikit-learn        | 1.x         | Entraînement et inférence du modèle       |
| Pandas / NumPy      | Standard    | Traitement des données                    |
| Pickle              | Standard    | Sérialisation du modèle entraîné          |

---

## Base de données

La base de données MySQL est nommée `gestion_prets`. Elle contient trois tables :

**Table `utilisateurs`**

Stocke les comptes administrateurs autorisés à se connecter à l'application.

```sql
CREATE TABLE utilisateurs (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    login       VARCHAR(50) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    nom_complet VARCHAR(100)
);
```

**Table `clients`**

Stocke les profils des clients bancaires avec leurs informations financières de base.

```sql
CREATE TABLE clients (
    id      INT PRIMARY KEY AUTO_INCREMENT,
    ville   VARCHAR(50),
    cp      VARCHAR(10),
    revenu  DOUBLE
);
```

**Table `prets`**

Stocke les dossiers de prêt associés à chaque client.

```sql
CREATE TABLE prets (
    id_pret         INT PRIMARY KEY AUTO_INCREMENT,
    client_id       INT,
    remboursement   DOUBLE,
    duree           INT,
    type            VARCHAR(20),
    taux            DOUBLE,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);
```

---

## Installation et démarrage

**Prérequis**

Avant de commencer, assurez-vous que les éléments suivants sont installés sur votre machine :

- JDK 11 ou supérieur
- Apache Maven 3.x
- Apache Tomcat 9.x
- MySQL 8.x
- Python 3.9+ (pour le module IA uniquement)
- IntelliJ IDEA (recommandé pour le développement Java)

**Étape 1 — Cloner le dépôt**

```bash
git clone https://github.com/gitHamzaHam/DigitalBank.git
cd DigitalBank
```

**Étape 2 — Configurer la base de données**

Connectez-vous à MySQL et créez la base de données :

```sql
CREATE DATABASE gestion_prets;
USE gestion_prets;
```

Exécutez ensuite les scripts de création des tables présentés dans la section précédente, puis insérez un compte administrateur :

```sql
INSERT INTO utilisateurs (login, password, nom_complet)
VALUES ('admin', 'votre_mot_de_passe', 'Hamza El Hamidine');
```

**Étape 3 — Configurer la connexion à la base de données**

Ouvrez le fichier `backend/src/main/java/com/banque/util/DBConnection.java` et modifiez les paramètres de connexion selon votre configuration locale :

```java
private static final String URL      = "jdbc:mysql://localhost:3306/gestion_prets";
private static final String USER     = "root";
private static final String PASSWORD = "votre_mot_de_passe";
```

**Étape 4 — Compiler et déployer le backend**

```bash
cd backend
mvn clean package
```

Déployez ensuite le fichier WAR généré dans le dossier `webapps` de Tomcat, ou configurez le déploiement directement depuis IntelliJ IDEA via la configuration Smart Tomcat.

**Étape 5 — Démarrer l'API IA (optionnel)**

```bash
cd ai
pip install -r requirements.txt
python app.py
```

L'API démarre par défaut sur `http://localhost:5000`.

**Étape 6 — Accéder à l'application**

Une fois Tomcat démarré, l'application est accessible à l'adresse :

```
http://localhost:8080/ProjetGestionprets/
```

Connectez-vous avec les identifiants administrateur créés à l'étape 2.

---

## Modèle de machine learning

Le module IA utilise un modèle de classification binaire entraîné pour prédire le risque de défaut de remboursement d'un client. Le modèle prend en entrée les variables suivantes :

- Le revenu mensuel du client
- Le montant de la mensualité de remboursement
- La durée totale du prêt (en mois)
- Le type de prêt (immobilier ou automobile, encodé numériquement)
- Le taux d'intérêt appliqué

La sortie du modèle est une classification en deux catégories : risque faible ou risque élevé. Le modèle a été entraîné avec l'algorithme Random Forest de Scikit-learn, reconnu pour sa robustesse sur des données tabulaires de taille modeste. Le fichier modèle sérialisé (`model.pkl`) est chargé au démarrage de l'API Flask et reste en mémoire pour répondre aux requêtes en temps réel.

---

## Conception UI/UX

L'interface utilisateur a été entièrement repensée pour adopter les codes visuels des applications bancaires modernes, en s'inspirant de produits comme Revolut, Stripe ou N26.

Les choix de design retenus sont les suivants :

- Un fond général en gris très clair pour faire ressortir les composants blancs
- Des cartes avec des ombres douces et des coins arrondis à 12px ou 16px
- Une palette de couleurs restreinte centrée sur l'indigo foncé comme couleur principale, le vert émeraude pour les indicateurs positifs, et le rouge rosé pour les alertes
- La police Plus Jakarta Sans pour sa lisibilité et son caractère moderne
- Des contrastes typographiques forts entre les valeurs financières (gras, grand corps) et les libellés (petit, grisé)
- Une navigation fixe en haut de page accessible depuis toutes les vues
- Un maximum d'espace blanc pour réduire la charge cognitive

---

## Points d'amélioration identifiés

Ce projet a été réalisé dans un cadre académique avec des contraintes de temps. Plusieurs axes d'amélioration ont été identifiés pour une version production :

- Hachage des mots de passe administrateurs (actuellement stockés en clair)
- Utilisation de requêtes préparées (PreparedStatement) dans toutes les Servlets pour prévenir les injections SQL
- Mise en place d'un système de rôles pour différencier les niveaux d'accès
- Internationalisation de l'interface (support français/arabe)
- Export des données clients et prêts au format CSV ou PDF
- Tests unitaires avec JUnit et Mockito sur la couche service
- Containerisation avec Docker pour faciliter le déploiement

---

## Licence

Ce projet est développé dans un cadre académique à l'ISGA. Il est partagé publiquement à des fins de démonstration et d'apprentissage. Toute réutilisation du code doit mentionner l'auteur original.

---

*Hamza El Hamidine — ISGA — 2026*
