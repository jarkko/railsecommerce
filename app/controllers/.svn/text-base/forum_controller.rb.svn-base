class ForumController < ApplicationController

  def index
    @post_pages, @posts = paginate :forum_posts, :per_page => 10, :order => 'root_id desc, lft'
  end

  def reply
    @parent_post = ForumPost.find(params[:id])
    @post = ForumPost.new
    @post.parent_id = @parent_post.id
    render :action => 'post'
  end

  def show
    @post = ForumPost.find(params[:id])
  end

  def post
    @post = ForumPost.new
  end

  def create
    @post = ForumPost.new(params[:post])
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'post'
    end
  end

  
end
