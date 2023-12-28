Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :currency_rates, only: :index do
    collection do
      get :usd
      get :eur
      get :cny
    end
  end
  root "currency_rates#index"

end
