class Item < ApplicationRecord
  validates :image, presence: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category #ActiveHash
end
