require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test') }

  before do
    # Create the post first and set the title attribute
    @post = Post.new(author: user, title: 'First post', text: 'This is my first post')
    @post.save

    # Now create comments and likes and associate them with the post
    Comment.create(author: user, post: @post, text: 'This is the first comment.')
    Comment.create(author: user, post: @post, text: 'This is the second comment.')
    Comment.create(author: user, post: @post, text: 'This is the third comment.')
    Comment.create(author: user, post: @post, text: 'This is the fourth comment.')
    Comment.create(author: user, post: @post, text: 'This is the fifth comment.')
    Comment.create(author: user, post: @post, text: 'This is the sixth comment.')

    Like.create(author: user, post: @post)
  end

  it 'title should not be blank' do
    expect(@post).to be_valid
  end

  it 'title cannot be set to nil' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'title should not be more than 250 characters long' do
    expect(@post).to be_valid
    @post.title = 'a' * 270
    expect(@post).to_not be_valid
  end

  it 'comments_counter should be an integer greater than or equal to zero' do
    expect(@post.comments_counter).to be >= 0
  end

  it 'likes_counter should be an integer greater than or equal to zero' do
    expect(@post.likes_counter).to be >= 0
  end

  describe '#recent_comments' do
    it 'should return not more than 5 comments' do
      expect(@post.recent_comments.size).to be <= 5
    end

    it 'should return zero length array for posts with no comments' do
      test_post = Post.create(author: user, title: 'Test post', text: 'This is my test post')
      expect(test_post.recent_comments.size).to eq(0)
    end
  end
end
