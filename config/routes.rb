require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get "up" => "rails/health#show", as: :rails_health_check

  resources :currency_rates, only: :index do
      get :last_four_weeks, on: :collection
  end

  root "currency_rates#index"
end
