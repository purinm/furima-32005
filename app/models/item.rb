class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :days_to_sip
  belongs_to_active_hash :prefectures
end
