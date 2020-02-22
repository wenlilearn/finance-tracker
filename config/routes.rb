Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get "my_portfolio", to: "users#my_portfolio"
  get "search_stock", to: "stocks#search"
  get "friends", to: "users#friends"
  get "search_friend", to: "friends#search"
  post "/friends/:id", to: "friends#create", as: "create_friend"
  delete "/friend/:id", to: "friends#remove", as: "friend"
end