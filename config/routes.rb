Rails.application.routes.draw do
  resources :system_alerts
  resources :emails
  resources :stations
  resources :aircrafts

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount_griddler('/email/incoming')

  get '/post', to: 'pages#post'

  delete 'system_alerts/destroy_all', to: 'system_alerts#destroy_all', as: :destroy_all_system_alerts
end
