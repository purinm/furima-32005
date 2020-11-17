class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  with_options presence: true do
    validates :user
    validates :description
    validates :image
  end

  belongs_to_active_hash :category
  extend ActiveHash::Associations::ActiveRecordExtensions
  #ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id, presence: true, numericality: { other_than: 1 }

  belongs_to_active_hash :condition
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :condition_id, presence: true, numericality: { other_than: 1 }

  belongs_to_active_hash :delivery_fee
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :delivery_fee_id, presence: true, numericality: { other_than: 1 }

  belongs_to_active_hash :days_to_sip
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :days_to_sip_id, presence: true, numericality: { other_than: 1 }

  belongs_to_active_hash :prefecture
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :prefecture_id, presence: true, numericality: { other_than: 1 }

  validates :cost, presence: true,
                   numericality: { only_integer: true, greater_than: 299, less_than: 10000000 },
                   format: { with: /\A(?=.*?\d)\d\z/ }
end
