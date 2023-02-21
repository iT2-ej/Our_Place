class Admin::FavoritesController < ApplicationController
  def index
    user = User.find(params[:id])
    @favorites = user.favorites
  end
  
  def destroy
    @favorite = Favorite.find_by(params[:id])
    @favorite.destroy
    redirect_to admin_favorites_path(id: @favorite.user.id)
  end
end
