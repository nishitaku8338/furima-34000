FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '08088883333' }
  end
  # association :user    order_addressは自分で生成した為、アソシエーション機能を持たない
  # association :item    order_addressは自分で生成した為、アソシエーション機能を持たない
end
