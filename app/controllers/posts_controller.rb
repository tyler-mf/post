class PostsController < ApplicationController
  include PostsHelper


  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
      if @post.save
        flash.notice = "Post'#{@post.title}' created!"

        redirect_to post_path(@post)
      else
        render action: "new"
      end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.update

      flash.notice = "Post '#{@post.title}' updated!"

      redirect_to posts_path(@post)
    else
      render action: "edit"
      end
    end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    flash.notice = "Post '#{@post.title}' deleted!"

    redirect_to posts_path
    
  end

end
