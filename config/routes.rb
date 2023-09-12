# frozen_string_literal: true

Rails.application.routes.draw do
  root 'foods#index'

  resources :users

  resources :recipes, only: %i[index show new update destroy create] do
    resources :recipe_foods, only: %i[new create edit update destroy]
  end

  resources :foods do
    resources :recipe_foods, only: %i[edit update new create destroy]
  end
end
