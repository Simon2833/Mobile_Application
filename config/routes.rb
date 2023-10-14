Rails.application.routes.draw do

  
  devise_for :users

  resources :desks

  
  get 'home/about'
  root 'home#index'
  
end