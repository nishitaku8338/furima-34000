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
  end
end
