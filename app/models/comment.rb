class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :gossip
  belongs_to :commentable, polymorphic: true, optional: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
end
