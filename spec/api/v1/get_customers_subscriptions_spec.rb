require 'rails_helper'

RSpec.describe "All subscriptions for a customer" do
  describe "happy path" do
    it "returns all a customer's subscriptions" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      tea_1, tea_2, tea_3 = create_list(:tea, 3)
      subscription_1 = create(:subscription, customer_id: customer_1.id, tea_id: tea_1.id)
      subscription_2 = create(:subscription, customer_id: customer_1.id, tea_id: tea_2.id)
      subscription_3 = create(:subscription, customer_id: customer_1.id, tea_id: tea_3.id)
      subscription_4 = create(:subscription, customer_id: customer_2.id, tea_id: tea_1.id)

      get "/api/v1/customers/#{customer_1.id}/subscriptions"

      expect(response).to be_successful
      subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(subscriptions).to be_a(Hash)
      expect(subscriptions).to have_key(:data)
      expect(subscriptions[:data].count).to eq(3)

      subscriptions[:data].each do |subscription|
        expect(subscription).to have_key(:id)
        expect(subscription[:id]).to be_a(String)

        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to be_a(String)

        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to be_a(Hash)

        expect(subscription[:attributes]).to have_key(:title)
        expect(subscription[:attributes][:title]).to be_a(String)
        expect(subscription[:attributes]).to have_key(:price)
        expect(subscription[:attributes][:price]).to be_a(String)
        expect(subscription[:attributes]).to have_key(:status)
        expect(subscription[:attributes][:status]).to be_a(String)
        expect(subscription[:attributes]).to have_key(:frequency)
        expect(subscription[:attributes][:frequency]).to be_a(String)
      end
    end
  end
end
