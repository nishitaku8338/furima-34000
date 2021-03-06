class Item < ApplicationRecord
  VALID_PRICEL_HALF = /\A[0-9]+\z/ # 半角数字以外を外す
  with_options presence: true do
    validates :image
    validates :item_name, length: { maximum: 40 }
    validates :item_description, length: { maximum: 1000 }
    validates :price, numericality: { with: VALID_PRICEL_HALF, message: 'Half-width number' }
  end
  validates :price, numericality: {
    greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
    message: 'Out of setting range' # messageオプションは一つのバリデーションで1回しか対応しない。
  } # priceカラムがinteger型の場合、バリデーションは「numericality」を使い「format」は使えない。
  with_options numericality: { other_than: 1, message: 'Select' } do # ジャンルの選択が「--」の時は保存できない
    validates :category_id
    validates :item_state_id
    validates :postage_id
    validates :region_id
    validates :shipping_data_id
  end

  belongs_to :user
  has_one_attached :image
  has_one :order
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category       # ActiveHash
  belongs_to :item_state     # ActiveHash
  belongs_to :postage        # ActiveHash
  belongs_to :region         # ActiveHash
  belongs_to :shipping_data  # ActiveHash
end
