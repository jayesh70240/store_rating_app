Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  root 'sessions#new'  # Default root to login page

  # Authentication routes
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/change_password', to: 'users#change_password'
  patch '/update_password', to: 'users#update_password'

  # Dashboards
  get '/store_owner/dashboard', to: 'stores#dashboard'
  get '/user/dashboard', to: 'users#dashboard'
  
  resources :stores do
    member do
      get 'dashboard'
      post 'submit_rating'
    end
  end
  
  namespace :admin do
    get 'dashboard', to: 'admin#dashboard'
    get 'users', to: 'admin#users'
    get 'stores', to: 'admin#stores'
    get 'users/new', to: 'admin#new_user', as: 'new_user'
    post 'users', to: 'admin#create_user'
    get 'stores/new', to: 'admin#new_store', as: 'new_store'
    post 'stores', to: 'admin#create_store'
  end
    
  
end
