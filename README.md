# Projet Gossip

## Description

Le projet Gossip est une application de réseau social développée avec Ruby on Rails. Elle permet aux utilisateurs de créer et partager des « gossips » (publications), de les taguer, de commenter les gossips et les commentaires, d’aimer les gossips et les commentaires, et d’envoyer des messages privés à d’autres utilisateurs. Chaque utilisateur est associé à une ville, et les gossips peuvent être recherchés selon différents critères : ville, utilisateur, date, nombre de likes et tags.
Nous nous intéressons ici aux fondamentaux des `models` et des `migrations`.

## Modèles

- **Utilisateur (User)** : Attributs : first_name, last_name, description, email, age. Appartient à une ville. Peut créer des gossips, des commentaires, des likes et envoyer/recevoir des messages privés.
- **Ville (City)** : Attributs : name, zip_code. Une ville possède plusieurs utilisateurs.
- **Gossip** : Attributs : title, content. Appartient à un utilisateur. Peut avoir plusieurs tags, commentaires et likes.
- **Tag** : Attribut : title. Peut être associé à plusieurs gossips.
- **Message Privé (PrivateMessage)** : Attribut : content. Possède un expéditeur (utilisateur) et plusieurs destinataires (utilisateurs).
- **Commentaire (Comment)** : Attribut : content. Appartient à un utilisateur et à un gossip. Supporte l’association polymorphe pour commenter d’autres commentaires.
- **Like** : Association polymorphe sur les gossips ou les commentaires. Appartient à un utilisateur.

## Instructions d’installation

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

4. Lancez le serveur Rails :

   ```bash
   rails server
   ```

5. Accédez à l’application sur `http://localhost:3000`.

## Utilisation

- Inscription des utilisateurs avec choix de la ville.
- Création de gossips avec tags.
- Commentaires sur les gossips et sur d’autres commentaires (commentaires imbriqués).
- Likes sur les gossips et les commentaires.
- Envoi de messages privés entre utilisateurs.

## Notes

- La base de données est pré-remplie avec des données d’exemple grâce à Faker.
- Les commentaires supportent l’imbrication via les associations polymorphes.
- Les likes sont polymorphes et peuvent s’appliquer aux gossips ou aux commentaires.

## Exemples de commandes Rails Console

Lancez la console avec :

```bash
rails console
```

Quelques exemples pour tester les modèles :

```ruby
# Créer un utilisateur
user = User.create(first_name: "Jean", last_name: "Dupont", description: "Testeur", email: "jean@exemple.com", age: 30, city: City.first)

# Créer un gossip
gossip = Gossip.create(title: "Mon premier gossip", content: "Ceci est un test.", user: user)

# Ajouter un tag à un gossip
tag = Tag.create(title: "Rumeur")
gossip.tags << tag

gossip.tags # => Affiche les tags associés

# Commenter un gossip
comment = Comment.create(content: "Super gossip !", user: user, gossip: gossip)

# Liker un gossip
like = Like.create(user: user, likeable: gossip)

# Envoyer un message privé
recipient = User.last
pm = PrivateMessage.create(content: "Salut !", sender: user)
pm.recipients << recipient

# Créer un commentaire sur un commentaire (commentaire imbriqué)
reply = Comment.create(content: "Merci !", user: recipient, commentable: comment)
```

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