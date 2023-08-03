require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  # Use let! to ensure posts are created before each scenario
  let!(:posts) do
    FactoryBot.create_list(:post, 11, author: user)
  end
  before do
    visit user_posts_path(user)
  end

  scenario 'I can see the user\'s profile picture' do
    expect(page).to have_css("img[src='#{user.photo}']") if user.photo.present?
  end

  scenario 'I can see the user\'s username' do
    expect(page).to have_content(user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  scenario 'I can see a post\'s title' do
    expect(page).to have_content(posts.last.title)
  end

  scenario 'I can see some of the post\'s body' do
    expect(page).to have_content(posts.last.text[0..50])
  end

  scenario 'I can see the first comments on a post' do
    first_post_comments = posts.first.comments
    expect(page).to have_content(first_post_comments.last.text) if first_post_comments.present?
  end

  scenario 'I can see how many comments a post has' do
    expect(page).to have_content("Comments: #{posts.last.comments.count}")
  end

  scenario 'I can see how many likes a post has' do
    expect(page).to have_content("Likes: #{posts.last.likes.count}")
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    # Check if pagination controls are present
    expect(page).to have_selector('.pagination-section', wait: 5)
  end

  scenario 'When I click on a post, it redirects me to that post\'s show page' do
    click_on posts.last.title # Click on the link of the last post in the list
    expect(current_path).to eq(user_post_path(user, posts.last))
  end
end
