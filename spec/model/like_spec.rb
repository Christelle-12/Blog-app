require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test') }
  let(:post) { Post.create(author: user, title: 'First post', text: 'This is my first post') }

  it 'should update post likes_counter after create' do
    expect(post.likes_counter).to eq(0)

    Like.create(author: user, post: post)

    post.reload
    expect(post.likes_counter).to eq(1)
  end
end
