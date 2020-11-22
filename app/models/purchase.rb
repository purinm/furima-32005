class Purchase < ApplicationRecord

  belongs_to :user
  has_one :address
  belongs_to :item

  # Orderモデル（Orderクラス）にtokenという属性が存在しないのをtokenについてもOrderモデルで使用できるようにする
  # tokenについてのバリデーションも記述することができるようになる
  attr_accessor :token

  validates :token, presence: true
  

end
