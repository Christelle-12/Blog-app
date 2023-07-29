class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def new
    @new_user_post = Post.new
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments.order(created_at: :desc).limit(5)
    @likes_count = @post.likes.count
    @comments_count = @post.comments.count
  end

  def create
    return unless current_user

    @post = Post.new(author: @current_user, title: values[:title], text: values[:text])

    if @post.save
      redirect_to user_post_path(params[:user_id], @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def add_like
  #   @post = Post.find(params[:id])
  #   @like = @post.likes.build(author: current_user)

  #   if @like.save
  #     redirect_to user_post_path(user_id: @post.author.id, id: @post.id), notice: 'Post liked successfully.'
  #   else
  #     redirect_to user_post_path(user_id: @post.author.id, id: @post.id), alert: 'Failed to like the post.'
  #   end
  # end

  private

  def values
    params.require(:post).permit(:title, :text)
  end
end
