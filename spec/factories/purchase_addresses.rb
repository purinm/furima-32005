FactoryBot.define do
  factory :purchase_address do
    token { 'aaaaaaa' }
    zip_code { '123-4567' }
    prefecture_id { Faker::Number.within(range: 2..48) }
    city { '東京都' }
    building { '東京ハイツ' }
    street { '東京ストリート' }
    phone_number { Faker::Number.number(digits: 11)}
  end
end
