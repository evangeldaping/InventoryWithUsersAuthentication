Rails.application.routes.draw do
  root 'pages#homepage'

  devise_for :users

  resources :products, only: %i[index show edit new create update destroy]
  resources :warehouses, only: %i[index show edit new create update destroy] do
   resources :stocks, only: %i[create]
  end
  resources :orders, only: %i[index new show create update destroy edit] do
    resources :order_items, only: %i[create destroy]
  end
end
