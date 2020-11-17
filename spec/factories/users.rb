FactoryBot.define do
  password = Faker::Internet.password(min_length: 6)
  
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email}
    
    password { password }
    password_confirmation { password }
    first_name { "山田" }
    last_name {"太郎"}
    first_furigana {"ヤマダ"}
    last_furigana {"タロウ"}
    birthday  {Faker::Date.between(from: '1930-01-01', to: '2015-12-31')}
  end
end
