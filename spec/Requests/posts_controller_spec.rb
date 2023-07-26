require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/user_id/posts' do
    it 'returns http success for the index action' do
      get '/users/user_id/posts'
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('this is the main page of post')
    end
  end
  describe 'GET /users/user_id/posts/:id' do
    it 'returns an http success' do
      get '/users/user_id/posts/:id'
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
      expect(response.body).to include('this is the show page of post ')
    end
  end
end
