require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      user1 = User.create(name: 'John Doe', photo: 'https://avatars.githubusercontent.com/u/123456789?v=4')
      user2 = User.create(name: 'Jane Doe', photo: 'https://avatars.githubusercontent.com/u/987654321?v=4')

      get '/users'
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
      expect(response.body).to include(user1.name)
      expect(response.body).to include(user2.name)
    end
  end

  describe 'GET /show' do
    it 'returns an http success' do
      user = User.create(name: 'John Doe', photo: 'https://avatars.githubusercontent.com/u/123456789?v=4')
      get "/users/#{user.id}"
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.photo)
      expect(response.body).to include(user.posts_counter.to_s)
    end
  end
end
