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
    end
  end
end
