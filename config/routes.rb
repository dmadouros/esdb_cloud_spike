Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources "correlated_messages", only: [:show]
  resources "messages", only: [:index, :show]
  resources "streams", only: [:index, :show]
  resources "categories", only: [:index, :show]
end
