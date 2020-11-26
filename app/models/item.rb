class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one :purchase
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :description
    validates :image
    validates :cost
  end

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

  validates :cost, numericality: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' }
  validates :cost, inclusion: { in: 300..9_999_999, message: 'は300~9.999.999円までの範囲で入力してくだい' }
end
