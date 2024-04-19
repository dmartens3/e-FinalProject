Rails.application.routes.draw do

  # Allow a route to find all products of a certain category
  get '/products/category/:category_id', to: 'products#show_by_category', as: 'products_by_category'
  # Manually add routes for all the cart junk since we need to use session
  get '/cart', to: 'cart#show', as: 'cart'
  post '/add_to_cart', to: 'cart#add_to_cart', as: 'add_to_cart'
  get '/cart/invoice', to: 'cart#invoice', as: 'checkout'
  patch 'cart/update_quantity', to: 'cart#update_quantity', as: :update_quantity_cart
  delete 'cart/remove_from_cart', to: 'cart#remove_from_cart', as: :remove_from_cart

  resources :sales
  resources :orders
  resources :statuses
  resources :products
  resources :provinces
  resources :categories

  devise_for :admins, controllers: {
        sessions: 'admin/sessions'
      }
      
  devise_for :users, controllers: {
        sessions: 'user/sessions',
        registrations: 'user/registrations'
      }
  



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "products#index"
end
