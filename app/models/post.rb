class Post < ApplicationRecord
  validates :content , presence: true, length: { maximum: 255 }
  
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :likers, through: :favorites, source: :user
end
