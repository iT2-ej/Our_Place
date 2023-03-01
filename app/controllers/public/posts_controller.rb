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
    @posts = Post.order(created_at: :desc).page(params[:page])
    tag_names = Tag.pluck(:tag_name)
    if params[:search] == nil || params[:search] == ''
      @posts= Post.order(created_at: :desc).page(params[:page]) 
    elsif tag_names.include?(params[:search])
      tag_ids = Tag.where(tag_name: params[:search]).pluck(:id)
      tagmaps = Tagmap.where(tag_id: tag_ids)
      post_ids = tagmaps.pluck(:post_id)
      @posts = Post.where(id: post_ids).order(created_at: :desc).page(params[:page])
    else
      #部分検索
      @posts = Post.where("body LIKE ? ",'%' + params[:search] + '%').order(created_at: :desc).page(params[:page])
    end
    @tag_list = Tag.all
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
