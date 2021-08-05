class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:id])
    subscriptions = Subscription.where(customer_id: customer.id)
    render json: SubscriptionSerializer.new(subscriptions)
  end

  def update
    subscription = Subscription.update(params[:id], subscription_params)
    render json: SubscriptionSerializer.new(subscription)
  end

  def create
    subscription = Subscription.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :tea_id, :customer_id)
  end
end
