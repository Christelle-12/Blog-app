require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test') }
  let(:post) { Post.create(author: user, title: 'First post', text: 'This is my first post') }

  it 'should update post comments_counter after create' do
    expect(post.comments_counter).to eq(0)

    Comment.create(author: user, post:, text: 'This is the first comment.')

    post.reload
    expect(post.comments_counter).to eq(1)
  end

  it 'should not update post comments_counter if post is not set' do
    expect(post.comments_counter).to eq(0)

    Comment.create(author: user, text: 'This is a comment without a post.', post: nil)

    post.reload
    expect(post.comments_counter).to eq(0)
  end
end
