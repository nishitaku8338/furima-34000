require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname、email、password、password_confirmation、last_name、first_name、last_name_reading、first_name_reading、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが６文字以上の半角英数字混合であれば登録できる' do
        @user.password = '000aaa'
        @user.password_confirmation = '000aaa'
        expect(@user).to be_valid
      end
      it 'last_nameが全角文字であれば登録できる' do
        @user.last_name = '佐藤'
        expect(@user).to be_valid
      end
      it 'first_nameが全角文字であれば登録できる' do
        @user.first_name = '次郎'
        expect(@user).to be_valid
      end
      it 'last_name_readingが全角カナであれば登録できる' do
        @user.last_name_reading = 'サトウ'
        expect(@user).to be_valid
      end
      it 'first_name_readingが全角カナであれば登録できる' do
        @user.first_name_reading = 'ジロウ'
        expect(@user).to be_valid
      end
      it 'birthdayの生年月日が全て選択されていれば登録できる' do
        @user.birthday = '1931-02-28'
        expect(@user).to be_valid
      end
    end

    context '新規登録ができないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailに@がないと登録できない' do
        @user.email = 'hoge'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '00aaa'
        @user.password_confirmation = '000aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは英数字混合でないと登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameが数字では登録できない' do
        @user.last_name = '00'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name  Full-width characters')
      end
      it 'last_nameが半角英文字では登録できない' do
        @user.last_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name  Full-width characters')
      end
      it 'last_nameが全角英文字では登録できない' do
        @user.last_name = 'AA'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name  Full-width characters')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameが数字では登録できない' do
        @user.first_name = '00'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name  Full-width characters')
      end
      it 'first_nameが半角英文字では登録できない' do
        @user.first_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name  Full-width characters')
      end
      it 'first_nameが全角英文字では登録できない' do
        @user.first_name = 'AA'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name  Full-width characters')
      end
      it 'last_name_readingが空では登録できない' do
        @user.last_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading can't be blank")
      end
      it 'last_name_readingが数字では登録できない' do
        @user.last_name_reading = '00'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading Full-width katakana characters')
      end
      it 'last_name_readingが半角英文字では登録できない' do
        @user.last_name_reading = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading Full-width katakana characters')
      end
      it 'last_name_readingが全角英文字では登録できない' do
        @user.last_name_reading = 'AA'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading Full-width katakana characters')
      end
      it 'last_name_readingがひらがなでは登録できない' do
        @user.last_name_reading = 'ああぁぁ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading Full-width katakana characters')
      end
      it 'last_name_readingが漢字では登録できない' do
        @user.last_name_reading = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading Full-width katakana characters')
      end
      it 'first_name_readingが空では登録できない' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank")
      end
      it 'first_name_readingが数字では登録できない' do
        @user.first_name_reading = '00'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading Full-width katakana characters')
      end
      it 'first_name_readingが半角英文字では登録できない' do
        @user.first_name_reading = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading Full-width katakana characters')
      end
      it 'first_name_readingが全角英文字では登録できない' do
        @user.first_name_reading = 'AA'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading Full-width katakana characters')
      end
      it 'first_name_readingがひらがなでは登録できない' do
        @user.first_name_reading = 'ああぁぁ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading Full-width katakana characters')
      end
      it 'first_name_readingが漢字では登録できない' do
        @user.first_name_reading = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading Full-width katakana characters')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'birthdayの西暦が空では登録できない' do
        @user.birthday = '01-01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'birthdayの月が空では登録できない' do
        @user.birthday = '1930-00-01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'birthdayの日が空では登録できない' do
        @user.birthday = '1930-01-00'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end

# テストコード実行コマンド
# bundle exec rspec spec/models/user_spec.rb