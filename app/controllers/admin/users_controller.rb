class Admin::UsersController < ApplicationController
  
  def index
   @user = User.new
   @users = User.all
  end
  
  def show
   @user = User.find(params[:id])
   @posts = @user.posts
   @comments = @user.comments
  end
  
  def edit
   @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])
   @user.update(user_params)
    redirect_to admin_user_path
  end
  
  private
  
  def user_params
   params.require(:user).permit(:user_name, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :introduction, :profile_image, :is_deleted)
  end
end
