class Public::PostsController < ApplicationController
  def new
    @post = Post.new 
  end
  
  def create
    @post = Post.new(post_params) 
    @post.user_id = current_user.id
    @post.save!
    redirect_to action: 'index' 
  end
  
  def index
    @posts = Post.all
  end
  
  private
    def post_params 
      params.require(:post).permit(:title, :body, :image) 
    end
end
