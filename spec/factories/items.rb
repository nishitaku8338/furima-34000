FactoryBot.define do
  factory :item do
    item_name { 'Aaあぁアァ1１一久々' }
    item_description { 'Aaあぁアァ1１一久々' }
    category_id { '2' }
    item_state_id { '2' }
    postage_id { '2' }
    region_id { '2' }
    shipping_data_id { '2' }
    price { '300' }

    association :user

    after(:build) do |item| # インスタンスが生成した後画像を生成
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
