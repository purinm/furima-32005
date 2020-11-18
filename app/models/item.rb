class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one :purchase
  has_one_attached :image

  with_options presence: true do
    validates :user
    validates :description
    validates :image
    validates :cost
  end

  #ジャンルの選択が「--」の時は保存できないようにする
  with_options presence: true, numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :days_to_sip_id
    validates :prefecture_id
  end

  belongs_to_active_hash :condition
  belongs_to_active_hash :category
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :days_to_sip
  belongs_to_active_hash :prefecture

  # validates :cost, presence: true,
  #                  numericality: { only_integer: true, greater_than: 299, less_than: 10000000 },
  #                  format: { with: /\A(?=.*?\d)\d\z/ }
  validates_inclusion_of :cost, in: 300..9_999_999, message: "Out of setting range"
end
