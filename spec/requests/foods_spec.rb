require 'rails_helper'

RSpec.describe 'FoodsController', type: :request do
  describe 'GET /index' do
    before do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
      get foods_path
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(200)
    end

    it 'correct template is rendered' do
      expect(response).to render_template(:index)
    end

    it 'the response body includes correct placeholder text' do
      expect(response.body).to include('Foods List')
    end
  end
end
