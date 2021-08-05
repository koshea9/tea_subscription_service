# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"

class Seed
  def self.start
    Subscription.destroy_all
    Tea.destroy_all
    Customer.destroy_all
    seed = Seed.new
    seed.generate_teas
    seed.generate_customers
    seed.generate_subscriptions
  end

  def generate_teas
    10.times do |i|
      tea = Tea.create!(
        title: Faker::Tea.variety,
        description: Faker::Coffee.notes,
        rating: Faker::Number.between(from: 0, to: 5),
        temperature: Faker::Number.between(from: 65, to: 105),
        brew_time: Faker::Number.between(from: 3, to: 12),
        image: Faker::Placeholdit.image
      )
    end
  end

  def generate_customers
    30.times do |i|
      customer = Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip_code: Faker::Address.zip_code[0..4],
      phone: Faker::PhoneNumber.cell_phone
    )
    end
  end

  def generate_subscriptions
    tea = Tea.all
    customer = Customer.all
    15.times do |i|
      subscription = Subscription.create!(
      price: Faker::Commerce.price(range: 0..35.0),
      status: rand(0..1),
      frequency: rand(0..2),
      tea_id: tea.sample.id,
      title: "#{tea.sample.title} subscription",
      customer_id: customer.sample.id
    )
    end
  end
end

Seed.start
