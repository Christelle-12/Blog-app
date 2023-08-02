# spec/views/user_show_spec.rb
require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before do
    scenario 'I can see the user profile picture.' do
      visit user_path
      expect(page).to have_css("img[src='#{user.photo}']") if user.photo.present?
    end
    scenario 'I can see the user name.' do
      visit user_path
      expect(page).to have_content(user.name)
    end
    scenario 'I can see three posts.' do
      visit user_path
      expect(page).to have_content(user.posts)
    end
    scenario 'I can see the number of posts the user has written.' do
      visit user_path
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
    scenario 'When I click a users post, it redirects me to that posts show page.' do
      visit user_path
      click_link 'Post'
      expect(page).to have_content(post.title)
    end
    scenario 'I can see the user\'s bio.' do
        user.update(bio: 'This is my bio.')
  
        visit user_path(user)
        expect(page).to have_content(user.bio)
      end
  
    scenario 'I can see a button that lets me view all of a user\'s posts.' do
      visit user_path(user)
      expect(page).to have_link('View All Posts', href: user_posts_path(user))
    end

    scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
      create_list(:post, 5, user: user)

      visit user_path(user)
      click_link('View All Posts', href: user_posts_path(user))
      expect(current_path).to eq(user_posts_path(user))
      end
    scenario 'I can see the users first 3 posts'
      visit user_path
      expect(page).to have_content(user.posts.first(3))
  end
end
