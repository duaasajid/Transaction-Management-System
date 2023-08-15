Rails.application.routes.draw do
# config/routes.rb
  resources :homes
  root to: 'homes#index'

  resources :users, only: [:new, :create]
  match '/login', to: 'users#login', via: [:get, :post]
  match '/users/:id/logout', to: 'users#logout', as: :logout_user , via: [:get, :post]

  get '/ping', to: 'ping#show', format: :json, as: :ping
  resources :accounts do
    resources :transactions
  end
end
