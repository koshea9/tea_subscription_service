FactoryBot.define do
  factory :subscription do
    title { "#{tea.title} subscription" }
    price { Faker::Number.number(digits: 5) }
    status { rand(0..1) }
    frequency { rand(0..2) }
    tea
    customer
  end
end
