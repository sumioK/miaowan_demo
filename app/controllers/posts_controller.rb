class PostsController < ApplicationController

  def new
    @post = Post.new()
  end

  def create
    if params[:image_id]
      @post = Post.new(
        content: params[:content] ,
        user_id: @current_user.id ,
        image_id: "image.jpg"
      )
      if @post.save
        @post.image_id = "#{@post.id}.jpg"
        @post.save
        File.binwrite("public/post_images/#{@post.image_id}" , params[:image_id].read)
        redirect_to("/posts/index")
      else
        render("posts/new")
      end
    else
      flash[:notice] = "画像が選択されていません"
      render("posts/new")
    end

  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id:params[:id])
  end

  def edit
    @post = Post.find_by(id:params[:id])
  end

  def update
    @post = Post.find_by(id:params[:id])
    @post.content = params[:content]

    if params[:image_id]
      File.binwrite("public/post_images/#{@post.image_id}" , params[:image_id].read)
    end
    
    if @post.save
      redirect_to("/posts/#{@post.id}")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id:params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end
end
