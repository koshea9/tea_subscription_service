Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get "/customers/:id/subscriptions", to: "subscriptions#index"
      post "customers/:id/subscriptions", to: "subscriptions#create"
      patch "/subscriptions/:id", to: "subscriptions#update"
    end
  end
end
