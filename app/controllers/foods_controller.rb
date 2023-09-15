class FoodsController < ApplicationController
  include FoodsHelper

  def index
    notice_message
    @foods = current_user.foods
  end

  def show; end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
    @food = Food.find(params[:id])
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: @food }
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    @food = Food.find(params[:id])
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to foods_path, notice: 'Food was successfully updated.' }
        format.json { render :index, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /foods
  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_path, notice: 'Food was successfully created.' }
        format.json { render :index, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food = Food.find(params[:id])
    respond_to do |format|
      if @food.destroy
        format.html { redirect_to foods_path, notice: 'Food was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html do
          redirect_to foods_path,
                      alert: 'The food was added to either recipe or inventory and could not be destroyed.'
        end
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.fetch(:food, {}).permit(:name, :measurement_unit, :price, :quantity)
  end
end
