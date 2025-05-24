# Nettoyage de la base de données
Like.destroy_all
Comment.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all
Tag.destroy_all

# Création des villes
10.times do
  City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end

# Création des utilisateurs
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    email: Faker::Internet.email,
    age: rand(18..80),
    city: City.all.sample,
    password: "password",
    password_confirmation: "password"
  )
end

# Création des tags
tags = [
  "Drôle", "Triste", "Informatif", "Choquant", "Inspirant", 
  "Politique", "Sport", "Célébrité", "Technologie", "Musique"
]

tags.each do |tag_title|
  Tag.create!(title: tag_title)
end

# Création des potins
20.times do
  gossip = Gossip.create!(
    title: Faker::Lorem.sentence(word_count: 3, random_words_to_add: 0).truncate(14),
    content: Faker::Lorem.paragraph(sentence_count: 3),
    user: User.all.sample
  )
  
  # Association de tags aléatoires à chaque potin
  gossip.tags << Tag.all.sample(rand(1..3))
end

# Création des commentaires
40.times do
  Comment.create!(
    content: Faker::Lorem.paragraph(sentence_count: 1),
    user: User.all.sample,
    gossip: Gossip.all.sample
  )
end

# Création des commentaires sur les commentaires
20.times do
  comment = Comment.all.sample
  Comment.create!(
    content: Faker::Lorem.paragraph(sentence_count: 1),
    user: User.all.sample,
    gossip: comment.gossip,
    commentable: comment
  )
end

# Création des likes
30.times do
  likeable = [Gossip, Comment].sample.all.sample
  Like.create!(
    user: User.all.sample,
    likeable: likeable
  )
end

puts "Seed terminé avec succès !"
puts "#{City.count} villes créées"
puts "#{User.count} utilisateurs créés"
puts "#{Tag.count} tags créés"
puts "#{Gossip.count} potins créés"
puts "#{Comment.count} commentaires créés"
puts "#{Like.count} likes créés"