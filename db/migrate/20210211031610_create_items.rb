class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t| 
      t.string :item_name,         null: false
      t.text :item_description,    null: false
      t.integer :category_id,      null: false
      t.integer :item_state_id,    null: false 
      t.integer :postage_id,       null: false
      t.integer :region_id,        null: false
      t.integer :shipping_data_id, null: false
      t.integer :price,            null: false
      t.references :user,          foreign_key: true
      t.timestamps
    end
  end
end
