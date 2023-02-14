class Public::PostsController < ApplicationController
  def new
    @post = Post.new 
  end
  
  def create
    @post = current_user.posts.new(post_params)
    @post.save!
    redirect_to public_posts_path
  end
  
  def index
    #@posts = Post.all
    @posts = Post.page(params[:page])
    #@favorite =
    # if params[:search] == nil || ''
    if params[:search] == nil || params[:search] == ''
      @posts= Post.all 
    # elsif params[:search] == ''
      # @posts= Post.all
    else
      #部分検索
      @posts = Post.where("body LIKE ? ",'%' + params[:search] + '%')
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments  #投稿詳細に関連付けてあるコメントを全取得
    @comment = Comment.new
  end
  
  private
    def post_params 
      params.require(:post).permit(:title, :body, :image) 
    end
end
