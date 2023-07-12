Rails.application.routes.draw do
  resources :system_alerts
  resources :emails
  resources :stations
  resources :registrations
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount_griddler('/email/incoming')

  get '/post', to: 'pages#post'

end
