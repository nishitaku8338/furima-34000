## users テーブル

|Column               |Type      |Options                     |
|---------------------|----------|----------------------------|
|nickname             |string    |null: false                 |
|email                |string    |null: false, unique: true   |
|encrypted_password   |string    |null: false                 |
|last_name            |string    |null: false                 |
|first_name           |string    |null: false                 |
|last_name_reading    |string    |null: false                 |
|first_name_reading   |string    |null: false                 |
|birthday             |date      |null: false                 |


### Association
has_many :items
has_many :orders



## items テーブル

|Column               |Type         |Options                          |
|---------------------|-------------|---------------------------------|
|image                |             |                                 |
|item_name            |string       |null: false                      |
|item_description     |text         |null: false                      |
|category             |string       |null: false                      |
|item_state           |string       |null: false                      |
|postage              |string       |null: false                      |
|region               |string       |null: false                      |
|shipping-data        |string       |null: false                      |
|price                |integer      |null: false                      |
|user                 |references   |null: false, foreign_key: true   |


### Association
belongs_to :user
has_one :orders



## orders デーブル

|Column               |Type         |Options                          |
|---------------------|-------------|---------------------------------|
|user                 |references   |null: false, foreign_key: true   |
|item                 |references   |null: false, foreign_key: true   |


### Association
belongs_to :user
belongs_to :item
has_one :addresses



## addresses テーブル

|Column               |Type         |Options                          |
|---------------------|-------------|---------------------------------|
|postal_code          |integer      |null: false                      |
|prefecture           |string       |null: false                      |
|city                 |string       |null: false                      |
|house_number         |string       |null: false                      |
|building_name        |string       |                                 |
|phone_number         |string       |unique: true                     |
|order                |references   |null: false, foreign_key: true   |


### Association
belongs_to :order