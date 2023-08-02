RSpec.describe 'User show page', type: :feature do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
  
    before do
      scenario 'I can see the user profile picture.' do
        visit user_path(user)
        expect(page).to have_css("img[src='#{user.photo}']") if user.photo.present?
      end
  
      scenario 'I can see the user name.' do
        visit user_path(user)
        expect(page).to have_content(user.name)
      end
  
      scenario 'I can see the number of posts the user has written.' do
        visit user_path(user)
        expect(page).to have_content("Number of posts: #{user.posts.count}")
      end
  
      scenario 'I can see the user bio.' do
        visit user_path(user)
        expect(page).to have_content(user.bio) if user.bio.present?
      end
  
      scenario 'I can see the user\'s first 3 posts.' do
        posts = create_list(:post, 5, user: user)
        visit user_path(user)
        expect(page).to have_content(posts.first.title)
        expect(page).to have_content(posts.second.title)
        expect(page).to have_content(posts.third.title)
        expect(page).not_to have_content(posts.fourth.title)
        expect(page).not_to have_content(posts.fifth.title)
      end
  
      scenario 'I can see a button that lets me view all of a user\'s posts.' do
        visit user_path(user)
        expect(page).to have_link('View All Posts', href: user_posts_path(user))
      end
  
      scenario 'When I click a user\'s post, it redirects me to that post\'s show page.' do
        visit user_path(user)
        click_link post.title
        expect(page).to have_content(post.title)
      end
  
      scenario 'When I click to see all posts, it redirects me to the user\'s post index page.' do
        visit user_path(user)
        click_link('View All Posts', href: user_posts_path(user))
        expect(current_path).to eq(user_posts_path(user))
      end
    end
  end
  