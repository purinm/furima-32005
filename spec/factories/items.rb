FactoryBot.define do
  factory :item do
    name { Faker::Name.last_name }
    description { Faker::Lorem.sentence }
    image { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 2..11) }
    condition_id { Faker::Number.within(range: 2..7) }
    delivery_fee_id { Faker::Number.within(range: 2..3) }
    days_to_sip_id { Faker::Number.within(range: 2..4) }
    prefecture_id { Faker::Number.within(range: 2..48) }
    cost { Faker::Number.within(range: 300..999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
