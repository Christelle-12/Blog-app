class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  after_initialize do
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_user_posts_counter
    author.increment!(:posts_counter)
  end
end
