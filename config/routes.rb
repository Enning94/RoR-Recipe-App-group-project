Rails.application.routes.draw do
  root 'foods#index'

  resources :foods
  resources :recipe_foods
  resources :users
  resources :recipes
  resources :public_recipes, only: %i[index show]

  # resources :recipes, only: [:index, :show, :new, :update, :destroy, :create] do
  #   resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
  # end

  # resources :foods do
  #   resources :recipe_foods, only: %i[edit, update, new create destroy]
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
