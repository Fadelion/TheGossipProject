class User < ApplicationRecord
  has_secure_password
  
  belongs_to :city
  has_many :gossips, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_private_messages, class_name: "PrivateMessage", foreign_key: "sender_id", dependent: :destroy
  has_and_belongs_to_many :received_private_messages, class_name: "PrivateMessage", join_table: "private_messages_users"
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  
  # Pour la fonctionnalité "Se souvenir de moi"
  attr_accessor :remember_token
  
  # Génère un token pour se souvenir de l'utilisateur
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Oublie un utilisateur
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Vérifie si le token fourni correspond au digest stocké
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # Crée un hash sécurisé d'une chaîne
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Génère un nouveau token aléatoire
  def self.new_token
    SecureRandom.urlsafe_base64
  end
end
