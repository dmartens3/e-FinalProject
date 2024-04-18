Rails.application.routes.draw do
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


  get 'home/index'
  get 'home/admin'
  get 'home/user'
  
  # Allow a route to find all products of a certain category
  get '/products/category/:category_id', to: 'products#show_by_category', as: 'products_by_category'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "products#index"
end
