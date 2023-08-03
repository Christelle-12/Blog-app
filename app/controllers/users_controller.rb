class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.includes(posts: %i[likes comments]).find(params[:id])
    @posts = @user.posts.includes(:comments, :likes).order(created_at: :desc).limit(3)
  end

  def destroy
    # Assuming you are using Devise for authentication
    sign_out current_user
    redirect_to new_user_session_path, notice: 'Signed out successfully.'
  end
end
