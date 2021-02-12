class Item < ApplicationRecord
  validates :image, presence: true
  validates :item_name, presence: true, length: { maximum: 40 }
  validates :item_description, presence: true, length: { maximum: 1000 }
  VALID_PRICEL_HALF = /\A[0-9]+\z/ # 半角数字以外を外す
  validates :price, presence: true,
  numericality: { with: VALID_PRICEL_HALF, message: "Half-width number" }
  validates :price, numericality: { 
    greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, 
    message: "Out of setting range" # messageオプションは一つのバリデーションで1回しか対応しない。
    } # priceカラムがinteger型の場合、バリデーションは「numericality」を使い「format」は使えない。
  with_options numericality: { other_than: 1, message: "Select"} do  #ジャンルの選択が「--」の時は保存できない
    validates :category_id
    validates :item_state_id
    validates :postage_id
    validates :region_id
    validates :shipping_data_id
  end
  
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category       #ActiveHash
  belongs_to :item_state     #ActiveHash
  belongs_to :postage        #ActiveHash
  belongs_to :region         #ActiveHash
  belongs_to :shipping_data  #ActiveHash
end
