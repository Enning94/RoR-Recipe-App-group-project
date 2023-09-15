class RecipeFoodsController < ApplicationController
  def index
    @recipe_foods = RecipeFood.all
  end

  def new
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.all
  end

  def create
    @recipe_food = RecipeFood.new(add_ingredients_params)
    @recipe_food.recipe_id = params[:recipe_id]
    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to recipe_path(@recipe_food.recipe_id), notice: 'Ingredient added successfully.' }
        format.json { render :show, status: :created, location: @recipe_food }
      else
        @recipe = Recipe.find(params[:recipe_id])
        @foods = Food.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: unprocessable_entity }
      end
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(@recipe_food.recipe_id)
    @foods = Food.all
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    id = @recipe_food.recipe_id
    respond_to do |format|
      if @recipe_food.update(add_ingredients_params)
        format.html { redirect_to recipe_path(id), notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_food }
      else
        format.html { render :edit }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    id = @recipe_food.recipe_id

    respond_to do |format|
      if @recipe_food.destroy
        format.html { redirect_to recipe_path(id), notice: 'Food was successfully removed.' }
        format.json { render :show, status: :ok, location: @recipe_food }
      else
        format.html { redirect_to recipe_path(id), alert: 'You are not authorized to remove this food.' }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_ingredients_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
