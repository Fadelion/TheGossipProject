class Tag < ApplicationRecord
  has_and_belongs_to_many :gossips
  
  validates :title, presence: true, uniqueness: true
end
