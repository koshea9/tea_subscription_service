require 'rails_helper'

RSpec.describe "Update a Customer's Subscription Endpoint" do
  before :each do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @tea_1, @tea_2, @tea_3 = create_list(:tea, 3)
    @subscription_1 = create(:active_subscription, customer_id: @customer_1.id, tea_id: @tea_1.id)
    @subscription_2 = create(:active_subscription, customer_id: @customer_1.id, tea_id: @tea_2.id)
    @subscription_3 = create(:active_subscription, customer_id: @customer_1.id, tea_id: @tea_3.id)
    @subscription_4 = create(:active_subscription, customer_id: @customer_2.id, tea_id: @tea_1.id)
  end

  describe "happy path" do
    it "allows a customer's subscription to be cancelled" do
      subscription_params = {
        status: 1
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/subscriptions/#{@subscription_1.id}", headers: headers, params:JSON.generate(subscription_params)

      expect(Subscription.find_by!(customer: @customer_1.id, tea: @tea_1.id).status).to eq("cancelled")
    end
  end

  describe "sad path" do
    it "returns an error message if subscription doesn't exist" do
      subscription_params = {
        status: 1
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/subscriptions/333", headers: headers, params:JSON.generate(subscription_params)

      expect(response.status).to eq(404)

      no_subscription = JSON.parse(response.body, symbolize_names: true)
      expect(no_subscription).to have_key(:errors)
      expect(no_subscription).to_not have_key(:data)
      expect(no_subscription[:errors][0]).to have_key(:message)
      expect(no_subscription[:errors][0][:message]).to be_a(String)
      expect(no_subscription[:errors][0]).to have_key(:code)
      expect(no_subscription[:errors][0][:code]).to be_a(Integer)
    end
  end
end
