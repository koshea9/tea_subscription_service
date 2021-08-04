FactoryBot.define do
  factory :subscription do
    title { "#{tea.title} subscription" }
    price { Faker::Commerce.price(range: 0..35.0) }
    status { rand(0..1) }
    frequency { rand(0..2) }
    tea
    customer

    factory :active_subscription do
      status { 0 }
    end
  end
end
