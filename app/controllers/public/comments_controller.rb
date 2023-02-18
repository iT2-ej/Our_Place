class Public::CommentsController < ApplicationController
  
  

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to public_posts_path
    else
      render "public/posts/index"
    end
  end
  
  def index
    @comments = Comment.all
  end
  
  def destroy
    @comment=Comment.find_by(params[:id])
    @comment.destroy
      flash[:notice] = 'コメントを削除しました'
    redirect_to "/public/posts"
  end
  
  
  private
  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
end
