require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品出品登録" do
    context '商品出品登録できるとき' do
      it 'image、item_name、item_description、category_id、item_state_id、postage_id、region_id、shipping_data_id、priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品登録できないとき' do
      it 'imageがないと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameがないと登録できない' do
        @item.item_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'item_descriptionがないと登録できない' do
        @item.item_description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description can't be blank")
      end
      it 'category_idが1だと登録できない' do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Select")
      end
      it 'item_state_idが1だと登録できない' do
        @item.item_state_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Item state Select")
      end
      it 'postage_idが1だと登録できない' do
        @item.postage_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage Select")
      end
      it 'region_idが1だと登録できない' do
        @item.region_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Region Select")
      end
      it 'shipping_data_idが1だと登録できない' do
        @item.shipping_data_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping data Select")
      end
      it 'priceがないと登録できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが全角数字だと登録できない' do
        @item.price = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end
      it 'priceが全角英文字だと登録できない' do
        @item.price = "A"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width number")
      end
      it 'priceが半角英文字だと登録できない' do
        @item.price = "a"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width number")
      end
      it 'priceがひらがなだと登録できない' do
        @item.price = "あぁ"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width number")
      end
      it 'priceが漢字だと登録できない' do
        @item.price = "山田"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width number")
      end
      it 'priceが299以下だと登録できない' do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end
      it 'priceが9999999以上だと登録できない' do
        @item.price = "10000000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end
    end
  end
end