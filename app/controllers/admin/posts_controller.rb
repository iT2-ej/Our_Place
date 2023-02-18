class Admin::PostsController < ApplicationController
  
  def destroy
    @post = Post.find_by(params[:id])
    @post.destroy
      flash[:notice] = '投稿を削除しました'
    redirect_to admin_user_path
  end
end
