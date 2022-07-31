class UsersController < ApplicationController
  before_action :set_current_user
  def new
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      profiel_image: "default_user.jpg"
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] ="Success sign up!"
      redirect_to("/posts/index")
    else
      render("users/new")
    end
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id

      flash[:notice] = "Login success"
      redirect_to("/")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logout success"
    redirect_to("/login")
  end

  def index
    @users = User.all.order(name: :DESC)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.introduction = params[:introduction]

    if params[:profiel_image]
      @user.profiel_image = "#{@user.id}.jpg"
      image = params[:profiel_image]
      File.binwrite("public/user_images/#{@user.profiel_image}" , params[:profiel_image].read)
    end

    if @user.save
      flash[:notice] = "編集が完了しました!"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

end
