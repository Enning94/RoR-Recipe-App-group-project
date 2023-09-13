Rails.application.routes.draw do
  devise_for :models
  devise_for :users
  resources :foods
  resources :recipe_foods
  resources :users
  resources :recipes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
