class UsersController < ApplicationController
  def index
    @users = User.all 
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.recent_posts
    @allposts = @user.posts
  end
end
