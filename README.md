# The Gossip Project

## Description

The Gossip Project est une application de réseau social développée avec Ruby on Rails. Elle permet aux utilisateurs de créer et partager des « gossips » (potins), de les taguer, de commenter les potins, d'aimer les potins et les commentaires, et d'envoyer des messages privés à d'autres utilisateurs.

## Fonctionnalités

### Système d'authentification
- Inscription avec email et mot de passe sécurisé
- Connexion/déconnexion
- Option "Se souvenir de moi" avec cookies
- Protection des routes sensibles

### Gestion des potins
- Création, lecture, modification et suppression de potins
- Association de tags aux potins
- Restriction des modifications aux auteurs uniquement

### Commentaires
- Ajout de commentaires sur les potins
- Modification et suppression de ses propres commentaires
- Affichage du nombre de commentaires

### Système de likes
- Like/unlike des potins et commentaires
- Compteur de likes
- Un utilisateur ne peut liker qu'une seule fois un élément

### Navigation par ville
- Page dédiée pour chaque ville
- Affichage des potins par ville
- Liens entre utilisateurs et villes

## Modèles

- **Utilisateur (User)** : first_name, last_name, description, email, age, password_digest, remember_digest
- **Ville (City)** : name, zip_code
- **Gossip** : title, content
- **Tag** : title
- **Message Privé (PrivateMessage)** : content
- **Commentaire (Comment)** : content
- **Like** : association polymorphe

## Installation

1. Clonez le dépôt :
   ```bash
   git clone <url-du-repo>
   cd TheGossipProject
   ```

2. Installez les dépendances :
   ```bash
   bundle install
   ```

3. Configurez la base de données :
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Lancez le serveur :
   ```bash
   rails server
   ```

5. Accédez à l'application sur `http://localhost:3000`

## Sécurité

- Mots de passe hachés avec bcrypt
- Protection CSRF
- Autorisations basées sur l'utilisateur
- Cookies chiffrés
- Validation des entrées utilisateur

## Auteurs
- [THIAM](https://github.com/thaliou)
- [ASSY](https://github.com/AssyaJalo)
- [SOUARE](https://github.com/bbkouty)
- [FANAR](https://github.com/fanarbandia)
- [MAIGA](https://github.com/Fadelion)

## Licence

Ce projet est open source et disponible sous licence MIT.

---
Développé dans le cadre d'un projet d'apprentissage de la programmation web avec Ruby on Rails