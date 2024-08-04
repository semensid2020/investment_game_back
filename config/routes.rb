Rails.application.routes.draw do
  root 'markets#show'
  get 'users/new', to: 'users#new', as: :new_user

  resources :markets, only: [:show] do
    member do
      post 'buy', to: "markets#buy"
      post 'sell', to: "markets#sell"
      get 'next_date', to: "markets#next_date"
    end
  end
end
