Rails.application.routes.draw do
  root 'foods#index'

  resources :foods
  resources :recipe_foods
  resources :users
  resources :recipes
  resources :public_recipes, only: %i[index show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
