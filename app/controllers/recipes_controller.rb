class RecipesController < ApplicationController
  load_and_authorize_resource
  include RecipesHelper

  def index
    @recipes = current_user.recipes.includes(:recipe_foods)
    flash.delete(:notice) unless request.referrer == new_recipe_url
  end

  def show
    notice_message
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])

    render :show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.public = params[:public] == 'Public'

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update recipe_params

    @recipe.public = params[:public] == 'Public'

    @recipe.save
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      if can? :destroy, @recipe
        @recipe.destroy
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to recipes_path, alert: 'Recipe was not deleted.' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_public
    @recipe = current_user.recipes.find_by(id: params[:id])
    @recipe&.update(public: !@recipe.public)
    redirect_to request.referrer || root_path
  end

  def general_shopping_list
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_id = params[:recipe_id]
    @user = current_user
    recipe_foods = @recipe.recipe_foods.includes(food: :user)
    user_foods = @user.foods

    @missing_foods = []

    recipe_foods.each do |recipe_food|
      user_food = user_foods.find_by(name: recipe_food.food.name)

      next unless user_food.nil? || user_food.quantity < recipe_food.quantity

      quantity_needed = recipe_food.quantity - (user_food&.quantity || 0)

      total_price_needed = quantity_needed * recipe_food.food.price

      @missing_foods << {
        food_name: recipe_food.food.name,
        quantity_needed:,
        price_per_unit: recipe_food.food.price,
        total_price_needed:
      }
    end

    @total_value_needed = @missing_foods.sum { |missing_food| missing_food[:total_price_needed] }
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
