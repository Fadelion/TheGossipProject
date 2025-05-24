class Gossip < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 3, maximum: 14 }
  validates :content, presence: true
end
