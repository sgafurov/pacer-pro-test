Rails.application.routes.draw do
  root "items#index"
  # get "/items", to: "items#index"
  # get "/items/:id", to: "items#show"
  # Rails provides a routes method named resources that maps all of the conventional routes for a collection of resources, such as items
  resources :items
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
