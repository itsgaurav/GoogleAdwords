Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  root "home#index"
  resources :keywords, only: [:index, :create, :show]
  
  namespace :v1 do
  	resources :keywords, only: [:index, :create]
  end
end
