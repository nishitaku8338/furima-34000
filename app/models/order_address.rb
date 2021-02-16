class OrderAddress
  include ActiveModel::Model
  attr_accessor :token,              # クレジットカード決済
                :user_id, :item_id,  # ordersテーブル外部キー
                :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number

  with_options presence: true do
    validates :token          # クレジットカード決済
    validates :user_id        # ordersテーブル外部キー
    validates :item_id        # ordersテーブル外部キー
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :house_number
    validates :phone_number, format: {with: /\A[0-9]+\z/, message: "Select"}
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)  # orderテーブル外部キー
    Address.crate(
      postal_code: postal_code, 
      prefecture_id: prefecture_id, 
      city: city, 
      house_number: house_number, 
      building_name: building_name, 
      phone_number: phone_number, 
      order_id: order.id             # addressesテーブル外部キー
    )
  end
end