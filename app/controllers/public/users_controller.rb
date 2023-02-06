class Public::UsersController < ApplicationController
  
  def new
  end
  
  def show
    @user = User.find(params[:id])
    @profile_image = @user.profile_image
  end
  
  def unsubscribe
   
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def edit
     @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to public_user_path(@user.id),notice: '会員情報を更新しました.'
    else
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:user_name, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :introduction, :profile_image)
  end
end
