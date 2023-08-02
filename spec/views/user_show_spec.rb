require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before do
    @user = FactoryBot.create(:user) # Use FactoryBot to create a user
    @post = FactoryBot.create(:post, author: @user)
    @likes_count = 0
    @comments_count = 0
    @comments = [] # Initialize an empty array for comments for this test
  end

  scenario 'I can see the user profile picture.' do
    @user.update(photo: 'http://example.com/user_profile_picture.jpg')
    visit user_path(@user)
    expect(page).to have_css("img[src='http://example.com/user_profile_picture.jpg']")
  end

  scenario 'I can see the user name.' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the post details.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.text)
    expect(page).to have_content("Likes: #{@likes_count}")
    expect(page).to have_content("Comments: #{@comments_count}")
  end

  # Update the scenario 'I can see the user\'s first 3 comments on the post.'
  scenario 'I can see the user\'s first 3 comments on the post.' do
    # Create 5 comments for the post with the associated user as the author
    @comments = FactoryBot.create_list(:comment, 5, post: @post, author: @user)
    visit user_post_path(@user, @post)
    expect(page).to have_content(@comments[0].text)
    expect(page).to have_content(@comments[1].text)
    expect(page).to have_content(@comments[2].text)
  end

  scenario 'I can see a button to create a new comment on the post.' do
    visit user_post_path(@user, @post)
    expect(page).to have_link('Create Comment', href: new_user_post_comment_path(@user, @post))
  end

  scenario 'I can see a button to like the post.' do
    visit user_post_path(@user, @post)
    expect(page).to have_button('Like Post')
  end
  scenario 'When I click on a user, I am redirected to that users show page' do
    visit user_path(@user)
    click_on @user.name
    expect(page).to have_content(@user.name)
  end
end
