class Public::Controller < ApplicationController
  
  def new
  end
  
  def show
    @user =　User.find(params[:id])
    @profile_images = @user.profile_images
  end

  def edit
  end
end
