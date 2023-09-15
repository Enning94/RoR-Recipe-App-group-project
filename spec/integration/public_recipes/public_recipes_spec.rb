require 'rails_helper'
describe '/public_recipes', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  scenario 'user can see and view a page' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    FactoryBot.create(:recipe, public: true)
    FactoryBot.create(:recipe, public: false)
    visit '/public_recipes'
    expect(page).to have_text('Public Recipes')
  end
end
