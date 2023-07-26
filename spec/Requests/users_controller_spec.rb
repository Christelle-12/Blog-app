require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users'
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('this is the main page of user')
    end
  end
  describe ' GET /show' do
    it 'returns an http success' do
      get '/users/:id'
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
      expect(response.body).to include('this is the show page of user')
    end
  end
end
