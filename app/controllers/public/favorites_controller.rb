class Public::FavoritesController < ApplicationController
  def create
    @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:id])
    @post_favorite.save!
    redirect_to public_posts_path(params[:id]) 
  end
  
  def index
    user = User.find(params[:id])
    @favorites = user.favorites
  end
  
  def destroy
   @post_favorite = Favorite.find(params[:id])
   @post_favorite.destroy
  redirect_to public_posts_path(params[:id]) 
  end
end
