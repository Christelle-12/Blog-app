class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, class_name: 'Post', foreign_key: :post_id, optional: true

  before_create :validate_post_presence
  after_create :update_post_comments_counter

  private

  def validate_post_presence
    throw(:abort) unless post
  end

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
