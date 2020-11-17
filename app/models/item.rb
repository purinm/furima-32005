class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  #ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id, presence: true, numericality: { other_than: 1 }

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :days_to_sip
  belongs_to_active_hash :prefectures
end
