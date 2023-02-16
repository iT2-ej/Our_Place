class Public::TagsController < ApplicationController
  def show
    tag = Tag.find(params[:id])
    @posts = Post.posts_search(tag.tag_name)
  end
end
