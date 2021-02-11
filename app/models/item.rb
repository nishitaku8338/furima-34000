class Item < ApplicationRecord
  validates :image, presence: true
  validates :category_id, numericality: { other_than: 1 } #ジャンルの選択が「--」の時は保存できない
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category #ActiveHash
end
