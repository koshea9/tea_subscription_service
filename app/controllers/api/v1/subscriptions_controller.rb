class Api::V1::SubscriptionsController < ApplicationController
  def index
    subscriptions = Subscription.where(customer_id: params[:id])
    render json: SubscriptionSerializer.new(subscriptions)
  end
end
