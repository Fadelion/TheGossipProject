class User < ApplicationRecord
  belongs_to :city
  has_many :gossips, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_private_messages, class_name: "PrivateMessage", foreign_key: "sender_id", dependent: :destroy
  has_and_belongs_to_many :received_private_messages, class_name: "PrivateMessage", join_table: "private_messages_users"
end
