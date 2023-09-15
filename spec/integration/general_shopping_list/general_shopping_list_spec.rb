require 'rails_helper'

describe 'General Shopping List', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'viewing the shopping list for a recipe' do
    recipe = FactoryBot.create(:recipe, public: true, user:)
    food1 = FactoryBot.create(:food, user:)
    food2 = FactoryBot.create(:food, user:)

    FactoryBot.create(:recipe_food, recipe:, food: food1)
    FactoryBot.create(:recipe_food, recipe:, food: food2)

    visit general_shopping_list_path(recipe.id)

    expect(page).to have_text(food2.name)
    recipe_foods = RecipeFood.where(recipe_id: recipe.id).includes(:food)

    recipe_foods.map do |rf|
      {
        id: rf.id,
        quantity: rf.quantity,
        recipe_id: rf.recipe_id,
        food_id: rf.food_id,
        name: rf.food.name
      }
    end
    expect(page).to have_text("Total value of food needed: $#{@total_value_needed}")
  end
end
