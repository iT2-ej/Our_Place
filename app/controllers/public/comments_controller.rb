class Public::CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @post.save
    redirect_to action: 'index'
  end
  
  def index
   @comments = Comment.all
  end
end
