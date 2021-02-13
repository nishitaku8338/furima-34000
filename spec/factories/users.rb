FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password = 'aaa111'
    password { password }
    password_confirmation { password }
    last_name { '山田' }
    first_name { '太郎' }
    last_name_reading { 'ヤマダ' }
    first_name_reading { 'タロウ' }
    birthday { '1930-01-31' }
  end
end
