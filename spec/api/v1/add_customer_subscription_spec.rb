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
                            status: "active",
                            frequency: "monthly",
                            tea_id: @tea_1.id,
                            customer_id: @customer_1.id
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/:id/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)
      created_subscription = Subscription.last

      expect(response).to be_successful
      expect(created_subscription.title).to eq(subscription_params[:title])
      expect(created_subscription.price).to eq(subscription_params[:price])
      expect(created_subscription.status).to eq(subscription_params[:status])
      expect(created_subscription.frequency).to eq(subscription_params[:frequency])
      expect(created_subscription.tea_id).to eq(subscription_params[:tea_id])
      expect(created_subscription.customer_id).to eq(subscription_params[:customer_id])
    end
  end
end
