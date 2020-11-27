class PurchaseAddress
  include ActiveModel::Model   # ActiveRecordを継承しform_withメソッド対応とバリデーション機能をプラスする

  attr_accessor :zip_code, :prefecture_id, :city, :street, :building, :phone_number, :item_id, :user_id, :token

  # テーブルにないカラム名全てを属性値として取得し値の更新を扱えるようにする
  # Formオブジェクトのインスタンスを生成した際にform_withの引数として利用できる

  # クレジットカード情報、トークン、郵便番号・都道府県・市区町村・番地・電話番号が必須であること
  with_options  presence: true do
    validates :token
    validates :zip_code
    validates :prefecture_id
    validates :city
    validates :street
    validates :phone_number
    validates :user_id
    validates :item_id
  end

  # 電話番号にはハイフンは不要で、11桁以内であること（09012345678となる）
  validates :phone_number, format: { with: /\A[0-9]{,11}\z/, message: 'is invalid. Include hyphen(-)' }

  # 郵便番号はハイフン要
  validates :zip_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }

  # 都道府県「 -- 」 1番目を選択しない
  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }

  def save
    # 購入記録の情報を保存
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    # 住所の情報を保存
    Address.create(zip_code: zip_code, prefecture_id: prefecture_id, city: city, street: street, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end
