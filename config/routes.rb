Rails.application.routes.draw do
  devise_for :users
root 'recipes#index'


resources :recipes, only: [:index, :show, :new, :update, :destroy, :create] do
  resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
end

resources :foods do
  resources :recipe_foods, only: %i[edit, update, new, create, index, destroy]
end

get 'general_shopping_list/:recipe_id', to: 'recipes#general_shopping_list', as: 'general_shopping_list'
patch 'recipes/:id/toggle_public', to: 'recipes#toggle_public', as: 'toggle_public'

resources :recipe_food, only: %i[index show edit update destroy]
resources :public_recipes, only: %i[index show]

resources :shopping_list, only: %i[index show]
resources :general_shopping_list, only: %i[index show]
end