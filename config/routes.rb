Rails.application.routes.draw do

  resources :desks

  
  get 'home/about'
  root 'home#index'
  
end