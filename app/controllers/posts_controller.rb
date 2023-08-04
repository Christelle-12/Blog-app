class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:likes, :comments)
  end

  def new
    @new_user_post = Post.new
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:likes, :comments).find(params[:id]) # Eager loading likes and comments
    @comments = @post.comments.order(created_at: :desc).limit(5)
    @likes_count = @post.likes.count
    @comments_count = @post.comments.count
  end

  def create
    return unless current_user

    @post = Post.new(author: current_user, title: params[:post][:title], text: params[:post][:text])

    if @post.save
      redirect_to user_post_path(params[:user_id], @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  
    # Check if the user is authorized to delete the post
    authorize! :destroy, @post
  
    # Delete associated likes first
    Like.where(post_id: @post.id).destroy_all
  
    # Delete associated comments
    Comment.where(post_id: @post.id).destroy_all
  
    if @post.destroy
      redirect_to user_posts_path(@user), notice: 'Post deleted successfully.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to delete the post.'
    end
  end
  
end
