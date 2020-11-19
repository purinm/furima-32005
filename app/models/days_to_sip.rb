class DaysToSip < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '1~2日で発送' },
    { id: 3, name: '3~4で発送' },
    { id: 4, name: '4~7で発送' }
  ]

  include ActiveHash::Associations
  has_many :items
end