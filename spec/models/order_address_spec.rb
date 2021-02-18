require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入機能の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep 0.05
    end

    context '商品購入ができるとき' do
      it 'すべての値(tokenを含む)が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end
    context '商品購入ができないとき' do
      it 'postal_codeが空だと保存できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeが全角数字の場合は保存できないこと' do
        @order_address.postal_code = '１２３-４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeがひらがなの場合は保存できないこと' do
        @order_address.postal_code = 'あいうえお'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeがカタカナの場合は保存できないこと' do
        @order_address.postal_code = 'アイウエオ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeが漢字の場合は保存できないこと' do
        @order_address.postal_code = '一二三'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'prefectureを1を選択すると保存できないこと' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture Select")
      end
      it 'cityは空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberは空だと保存できないこと' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberは空だと保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは全角数字だと保存できないこと' do
        @order_address.phone_number = "０８０８８８８３３３３"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number Input only number")
      end
      it 'phone_numberはひらがなだと保存できないこと' do
        @order_address.phone_number = "あいうえお"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number Input only number")
      end
      it 'phone_numberはカタカナだと保存できないこと' do
        @order_address.phone_number = "アイウエオ"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number Input only number")
      end
      it 'phone_numberは漢字だと保存できないこと' do
        @order_address.phone_number = "一二三"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number Input only number")
      end
      it 'phone_numberは十桁以上半角数字入力しないと番号保存できないこと' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number Input only number")
      end
      it "tokenが空では登録できないこと" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it "user_idが紐付いていないと登録できないこと" do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it "item_idが紐付いていないと登録できないこと" do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

# テストコード実行コマンド
# bundle exec rspec spec/models/order_address_spec.rb