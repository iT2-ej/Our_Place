class Public::UsersController < ApplicationController
  
  def new
  end
  
  def show
    @user = User.find(params[:id])
    @profile_image = @user.profile_image
  end

  def edit
     @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path,notice: '会員情報を更新しました.'
    else
      render :edit
    end
  end
end
