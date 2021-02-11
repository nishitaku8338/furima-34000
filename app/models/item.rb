class Item < ApplicationRecord
  validates :image, presence: true
  validates :category_id, numericality: { other_than: 1 } #ジャンルの選択が「--」の時は保存できない
  
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category #ActiveHash
  belongs_to :item_state #ActiveHash
end
