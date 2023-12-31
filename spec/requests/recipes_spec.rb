# spec/request/recipes_spec.rb
require 'rails_helper'

RSpec.describe 'RecipesController', type: :request do
  describe 'GET /index' do
    before do
      user = FactoryBot.create(:user)
      sign_in user
      get recipes_path
    end

    context 'renders the index template' do
      it 'response status is correct' do
        expect(response).to have_http_status(200)
      end

      it 'correct template is rendered' do
        expect(response).to render_template(:index)
      end

      it 'the response body includes correct placeholder text' do
        expect(response.body).to include('Recipes List')
      end
    end
  end
end
