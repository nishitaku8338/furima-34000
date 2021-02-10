require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context '新規登録できるとき' do
      it 'nickname、email、password、password_confirmation、last_name、first_name、last_name_reading、first_name_reading、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが６文字以上の半角英数字混合であれば登録できる' do
        @user.password = "000aaa"
        @user.password_confirmation = "000aaa"
        expect(@user).to be_valid
      end
      it 'last_nameが全角文字であれば登録できる' do
        @user.last_name = "佐藤"
        expect(@user).to be_valid
      end
      it 'first_nameが全角文字であれば登録できる' do
        @user.first_name = "次郎"
        expect(@user).to be_valid
      end
      it 'last_name_readingが全角カナであれば登録できる' do
        @user.last_name_reading = "サトウ"
        expect(@user).to be_valid
      end
      it 'first_name_readingが全角カナであれば登録できる' do
        @user.first_name_reading = "ジロウ"
        expect(@user).to be_valid
      end
      it 'birthdayの生年月日が全て選択されていれば登録できる' do
        @user.birthday = "1931-02-28"
        expect(@user).to be_valid
      end
    end
  end
end
