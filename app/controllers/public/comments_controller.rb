class Public::CommentsController < ApplicationController
  
  def show
    @post_id = params[:id]

    @comment = Comment.new
  end

  #def create
  #  @comment = current_user.comments.new(comment_params)
  #  if @comment.save
  #    redirect_to public_posts_path
  #  else
  #    render "public/posts/index"
  #  end
   #  end
  
  def edit 
    @comment = Comment.find(params[:id])
    @post_id = params[:id]

  end
  
  def create
    comment = Post.find(comment_params[:post_id]).comments.new(comment_params)
    comment.user_id = current_user.id
    comment.save
    redirect_to public_posts_path
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
    params.require(:comment).permit(:post_id, :comment_content)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
end
