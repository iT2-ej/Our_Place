class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  
  def new
    @post = Post.new 
  end
  
  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tag_name].split(nil)
    @post.image.attach(params[:post][:image])
    @post.user_id = current_user.id
    if @post.save
       @post.save_posts(tag_list)
      redirect_to public_posts_path
    else
      flash.now[:alert] = '投稿に失敗しました'
      render 'new'
    end
  end
  
  def index
    @posts = Post.page(params[:page])
    @tag_list = Tag.all
    if params[:search] == nil || params[:search] == ''
      @posts= Post.page(params[:page]) 
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
    else
      #部分検索
      @posts = Post.where("body LIKE ? ",'%' + params[:search] + '%').page(params[:page])
    end
      @tag_lists = Tag.all
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments  #投稿詳細に関連付けてあるコメントを全取得
    @comment = Comment.new
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_user_path(@post.user)
  end
  
  private
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_path unless @post
    end
  
    def post_params 
      params.require(:post).permit(:title, :body, :image) 
    end
end
