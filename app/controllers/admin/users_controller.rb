class Admin::UsersController < ApplicationController
  
  def index
   @user = User.new
   @users = User.all
  end
  
  private
  
  def user_params
   params.require(:user).permit(:user_name, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :introduction, :profile_image)
  end
end
