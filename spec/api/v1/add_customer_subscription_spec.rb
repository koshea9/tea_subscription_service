require 'rails_helper'

RSpec.describe "Add Customer Subscription Endpoint" do
  before :each do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @tea_1, @tea_2, @tea_3 = create_list(:tea, 3)
  end
  describe "happy path" do
    it "creates a subscription for a customer" do
      subscription_params = {
                            title: "#{@tea_1.title} subscription",
                            price: 9.99,
                            frequency: "monthly",
                            tea_id: @tea_1.id,
                            customer_id: @customer_1.id
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{@customer_1.id}/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)
      created_subscription = Subscription.last

      expect(response).to be_successful
      expect(created_subscription.title).to eq(subscription_params[:title])
      expect(created_subscription.price).to eq(subscription_params[:price])
      expect(created_subscription.status).to eq("active")
      expect(created_subscription.frequency).to eq(subscription_params[:frequency])
      expect(created_subscription.tea_id).to eq(subscription_params[:tea_id])
      expect(created_subscription.customer_id).to eq(subscription_params[:customer_id])
    end
  end

  describe "sad path" do
    it "returns an error message if missing a required request parameter" do
      subscription_params = {
                            title: "#{@tea_1.title} subscription",
                            price: 9.99,
                            frequency: "monthly",
                            tea_id: @tea_1.id
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{@customer_1.id}/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)

      expect(response.status).to eq(400)

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
