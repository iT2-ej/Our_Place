class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  
  def new
  end
  
  def show
    @user = User.find(params[:id])
    @profile_image = @user.profile_image
    # byebug
    @posts = @user.posts
  end
  
  def unsubscribe
   
  end

  def withdraw
    current_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to public_user_path(@user),notice: '会員情報を更新しました.'
    else
      render :edit
    end
  end
  
  ##追加分
  def usercomment
    @user=User.find(params[:id])
  end
  
  private
  
  def correct_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :introduction, :profile_image)
  end
end
