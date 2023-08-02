class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(posts: %i[likes comments]).find(params[:id])
    @posts = @user.posts.includes(:comments, :likes).order(created_at: :desc).limit(3)
  end
end
