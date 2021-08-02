FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Coffee.notes }
    rating { Faker::Number.between(from: 0, to: 5) }
    temperature { Faker::Number.between(from: 65, to: 105) }
    brew_time { Faker::Number.between(from: 3, to: 12) }
    image { Faker::Placeholdit.image }
  end
end
