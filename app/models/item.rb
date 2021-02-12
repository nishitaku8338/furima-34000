class Item < ApplicationRecord
  validates :image, presence: true
  validates :item_name, presence: true, length: { maximum: 40 }
  validates :item_description, presence: true, length: { in: 7..1000 }
  VALID_PRICEL_HALF = /\A[0-9]+\z/       # 300~9999999、半角数字以外を外す
  validates :price, presence: true,
    format: {with: VALID_PRICEL_HALF},
    length: {minimum: 3, maxinum: 7},
    numericality: { 
    only_integer: true,                                            # 数値のみ
    greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999  # 指定された値以上、指定された値以下
    }
  validates :category_id, numericality:      { other_than: 1 } #ジャンルの選択が「--」の時は保存できない
  validates :item_state_id, numericality:    { other_than: 1 }
  validates :postage_id, numericality:       { other_than: 1 }
  validates :region_id, numericality:        { other_than: 1 }
  validates :shipping_data_id, numericality: { other_than: 1 }
  
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category       #ActiveHash
  belongs_to :item_state     #ActiveHash
  belongs_to :postage        #ActiveHash
  belongs_to :region         #ActiveHash
  belongs_to :shipping_data  #ActiveHash
end
