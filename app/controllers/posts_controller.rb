class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts =
    case params[:sort_by]
    when 'alphabetical'         then Post.order(title: :asc)
    when 'alphabetical_reverse' then Post.order(title: :desc)
    when 'time_posted_reverse'  then Post.order(created_at: :asc)
    when 'time_posted'          then Post.order(created_at: :desc)
    else
      Post.order(created_at: :desc)
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
