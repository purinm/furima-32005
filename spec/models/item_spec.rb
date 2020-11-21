require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @item = FactoryBot.build(:item)
  end

  it '必要な情報を適切に入力すると、商品の出品ができること' do
    expect(@item).to be_valid
  end

  it '商品画像を1枚つけることが必須であること' do
    @item.image = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Image can't be blank")
  end
  it '商品名が空では登録できないこと' do
    @item.name = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Name can't be blank")
  end
  it '商品の説明が空では登録できないこと' do
    @item.description = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Description can't be blank")
  end
  it 'カテゴリーの情報が空では登録できないこと' do
    @item.category_id = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Category can't be blank")
  end
  it '商品の状態についての情報が空では登録できないこと' do
    @item.condition_id = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Condition can't be blank")
  end
  it '配送料の負担についての情報が空では登録できないこと' do
    @item.delivery_fee_id = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
  end
  it '発送元の地域についての情報が空では登録できないこと' do
    @item.prefecture = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Prefecture can't be blank")
  end
  it '発送までの日数についての情報が空では登録できないこと' do
    @item.days_to_sip = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Days to sip can't be blank")
  end
  it '価格についての情報が空では登録できないこと' do
    @item.cost = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Cost can't be blank")
  end

  it '価格の範囲が、300円未満で登録できないこと' do
    @item.cost = '299'
    @item.valid?
    expect(@item.errors.full_messages).to include('Cost は300~9.999.999円までの範囲で入力してくだい')
  end
  it '価格の範囲が、¥9.999.999円より値段が高いと登録できないこと' do
    @item.cost = '10000000'
    @item.valid?
    expect(@item.errors.full_messages).to include('Cost は300~9.999.999円までの範囲で入力してくだい')
  end

  it '販売価格は半角数字のみ保存可能であること' do
    @item.cost = 'aaa'
    @item.valid?
    expect(@item.errors.full_messages).to include('Cost は半角数字で入力してください')
  end
  it 'カテゴリーに--を選択すると登録できないこと' do
    @item.category_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include('Category must be other than 1')
  end
  it '商品の状態に--を選択すると登録できないこと' do
    @item.condition_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include('Condition must be other than 1')
  end
  it '配送料の負担に--を選択すると登録できないこと' do
    @item.delivery_fee_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include('Delivery fee must be other than 1')
  end
  it '発送元の地域に--を選択すると登録できないこと' do
    @item.prefecture_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
  end
  it '発送までの日数に--を選択すると登録できないこと' do
    @item.days_to_sip_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include('Days to sip must be other than 1')
  end
end
