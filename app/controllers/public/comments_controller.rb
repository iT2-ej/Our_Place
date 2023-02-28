class Public::CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
    @post_id = params[:post_id]
  end
  
  def usercomment
     
  end
  
  def show
    @post_id = params[:post_id]
    @comment = Comment.new
  end
  
  def edit 
    @comment = Comment.find(params[:id])
    @post_id = params[:post_id]

  end
  
  def create
    comment = Post.find(params[:post_id]).comments.new(comment_params)
    comment.user_id = current_user.id
    comment.save
    redirect_to public_posts_path
  end
  
  def index
    @comments = current_user.comments
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment=Comment.find(params[:id])
    @comment.destroy
      flash[:notice] = 'コメントを削除しました'
    redirect_to public_post_comments_path(@post)
  end
  
  def update
    comment = Comment.find(params[:id])
    comment.user_id = current_user.id
    comment.comment_content = params[:comment][:body]
    if !comment.save
      redirect_to "/public/posts"
    else
      redirect_to "/public/posts"
    end
  end
  
  
  private
  def comment_params
    params.require(:comment).permit(:image, :comment_content)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
end
