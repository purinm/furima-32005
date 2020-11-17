require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'password_confirmationが空では登録できないこと' do
      @user.password_confirmation = nil
      @user.valid?
    end
    it 'first_nameが空では登録できないこと' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'last_nameが空では登録できないこと' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'first_furiganaが空では登録できないこと' do
      @user.first_furigana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First furigana can't be blank")
    end
    it 'last_furiganaが空では登録できないこと' do
      @user.last_furigana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last furigana can't be blank")
    end
    it 'birthdayが空では登録できないこと' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは、@を含まないと登録できないこと' do
      @user.email = 'aaaa.aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが6文字以上であれば登録できること' do
      @user.password = 'a12345'
      @user.password_confirmation = 'a12345'
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'password:半角英数混合の入力が必須であること' do
      @user.password = 'aaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password は英数字混合で入力してください')
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = 'a123456'
      @user.password_confirmation = 'a123457'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'ユーザー苗字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name は全角文字を使用してください')
    end

    it 'ユーザー名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'taro'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name は全角文字を使用してください')
    end

    it 'ユーザー苗字のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.first_furigana = 'taro'
      @user.valid?
      expect(@user.errors.full_messages).to include('First furigana は全角カナ文字を使用してください')
    end
    it 'ユーザー名前のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.last_furigana = 'taro'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last furigana は全角カナ文字を使用してください')
    end
  end
end
