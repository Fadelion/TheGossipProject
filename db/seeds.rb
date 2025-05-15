# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Effacer les données existantes
Like.destroy_all
Comment.destroy_all
PrivateMessage.destroy_all
Tag.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all

# créér les villes
cities = 10.times.map do
  City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end

# Créér les utilisateurs
users = 10.times.map do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 10),
    email: Faker::Internet.email,
    age: rand(18..70),
    city: cities.sample
  )
end

# Créér les Tags
tags = 10.times.map do
  Tag.create!(
    title: Faker::Lorem.unique.word
  )
end

# Créér des potins
gossips = 20.times.map do
  gossip = Gossip.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 2),
    user: users.sample
  )
  # Assigner au moins un tag
  gossip.tags << tags.sample(rand(1..3))
  gossip.save!
  gossip
end

# Créér un message privé
5.times do
  sender = users.sample
  recipients = users.sample(rand(1..3)).reject { |u| u == sender }
  pm = PrivateMessage.create!(
    content: Faker::Lorem.sentence(word_count: 10),
    sender: sender
  )
  pm.recipients << recipients
  pm.save!
end

# Créér des commentaires sur les potins
comments = 20.times.map do
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 8),
    user: users.sample,
    gossip: gossips.sample,
    commentable: nil
  )
end

# Créér des commentaires sur les commentaires
comments_on_comments = 10.times.map do
  parent_comment = comments.sample
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 6),
    user: users.sample,
    gossip: parent_comment.gossip,
    commentable: parent_comment
  )
end

# Créér les likes sur les potins et/ou les commentaires
20.times do
  likeable = [ gossips, comments + comments_on_comments ].flatten.sample
  Like.create!(
    user: users.sample,
    likeable: likeable
  )
end
