Rails.application.routes.draw do
  resources :reservations

  
  devise_for :users

  resources :desks

  
  get 'home/about'
  root 'home#index'
  
end