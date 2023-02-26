class Admin::CommentsController < ApplicationController
  def index
    user = User.find(params[:id])
    @comments = user.comments
    
  end
  
  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy if @comment
    flash[:notice] = 'コメントを削除しました'
    redirect_to admin_comments_path(id: @comment.user.id)
  end
end
