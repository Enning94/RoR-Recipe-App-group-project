class PublicRecipesController < ApplicationController
    def index
      @public_recipes = User.includes(:recipes).where(recipes: { public: true })
    end
  
    def show
      @recipe = Recipe.includes(:recipe_foods).find(params[:id])
      @recipe_id = @recipe.id
      @inventories = Inventory.all
  
      render :show
    end
  end
  