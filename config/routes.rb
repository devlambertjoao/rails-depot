Rails.application.routes.draw do
  devise_for :users

  resources :products

  get 'admin', to: 'admin#index', as: 'admin_index'

  get 'store', to: 'store#index', as: 'store_index'

  post 'store/add_to_cart', to: 'store#add_to_cart', as: 'add_to_cart'
  get 'store/clean_cart', to: 'store#clean_cart', as: 'clean_cart'
  get 'store/cart', to: 'store#show_cart', as: 'show_cart'

  root 'home#index'
end
