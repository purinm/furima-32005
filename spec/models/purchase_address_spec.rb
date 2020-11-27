require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '配送先と購入記録の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
    end

    context '商品購入ができる時' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end
      it '建物情報は空でも保存できること' do
        @purchase_address.building = nil
        expect(@purchase_address).to be_valid
      end
    end

    context '商品購入ができない時' do
      it 'tokenが空だと保存できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空だと保存できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
      end
      it 'item_idが空だと保存できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
      end
      it '郵便番号が空だと保存できないこと' do
        @purchase_address.zip_code = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Zip code can't be blank")
      end
      it '郵便番号がハイフンを含まないと保存できないこと' do
        @purchase_address.zip_code = '2222222'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end
      it '都道府県 に -- を選択すると保存できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture Select")
      end
      it '市区町村が空だと保存できないこと' do
        @purchase_address.city = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @purchase_address.street = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Street can't be blank")
      end

      it '電話番号にはハイフンがあれば保存できないこと' do
        @purchase_address.phone_number = '0-1234-5678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid. Include hyphen(-)')
      end
      it '電話番号には11桁以上であれば保存できないこと' do
        @purchase_address.phone_number = '01234567890'
        @purchase_address.valid?
      end
    end
  end
end
