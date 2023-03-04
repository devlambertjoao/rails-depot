Rails.application.routes.draw do
  devise_for :users

  resources :products

  get 'admin', to: 'admin#index', as: 'admin_index'

  get 'store', to: 'store#index', as: 'store_index'

  root 'home#index'
end
