class City < ApplicationRecord
  has_many :users, dependent: :destroy
  
  validates :name, presence: true
  validates :zip_code, presence: true
end
