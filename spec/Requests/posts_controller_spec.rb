require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    it 'returns http success for the index action' do
      user = User.create(name: 'John Doe', photo: 'https://avatars.githubusercontent.com/u/123456789?v=4')
      post1 = user.posts.create(title: 'My first post', text: 'This is my first post')
      post2 = user.posts.create(title: 'My second post', text: 'This is my second post')

      get "/users/#{user.id}/posts"
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
      expect(response.body).to include(post1.title)
      expect(response.body).to include(post2.title)
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'returns an http success' do
      user = User.create(name: 'John Doe', photo: 'https://avatars.githubusercontent.com/u/123456789?v=4')
      post = user.posts.create(title: 'My first post', text: 'This is my first post')

      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(post.title)
      expect(response.body).to include(post.text)
    end
  end
end
