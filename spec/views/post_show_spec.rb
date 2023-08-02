require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }
  let!(:comments) { FactoryBot.create_list(:comment, 3, post:, author: user) }

  before do
    # Set the initial number of likes
    post.update(likes_counter: 5)

    # Manually add likes to the post to update likes_counter
    FactoryBot.create_list(:like, 3, post:)

    # Reload the post to update the likes_counter
    post.reload

    visit user_post_path(post.author, post)
  end

  it 'displays the post\'s title' do
    expect(page).to have_content(post.title)
  end

  it 'displays the post author\'s name' do
    expect(page).to have_content(post.author.name)
  end

  it 'displays how many comments the post has' do
    expect(page).to have_content("Comments: #{post.comments.count}")
  end

  it 'displays how many likes the post has' do
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end

  it 'displays the post body' do
    expect(page).to have_content(post.text)
  end

  it 'displays the username of each commenter' do
    comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end

  it 'displays the comment left by each commenter' do
    comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
