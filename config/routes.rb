Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  devise_for :users
  root "welcome#index"

  get "welcome", to: "welcome#index"

  get "my_portfolio", to: "users#my_portfolio"
  get "search_stock", to: "stocks#search"

  get 'friends', to: "users#my_friends"
  get "search_friends", to: "friends#search_db"
  resources :users, only: [:show]
  
end
