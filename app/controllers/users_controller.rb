class UsersController < ApplicationController
  before_action :login_confirmation , only:[:index, :show, :followings, :followers, :likes, :character]
  before_action :set_user , only:[:show,:edit,:update,:destroy,:followings,:followers,:likes,:character]
    
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "ユーザーを登録しました"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザーの登録に失敗しました"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー内容を更新しました"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザー内容を更新できませんでした"
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to signup_url 
  end
  
  def followings
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @likings = @user.likings.page(params[:page])
    counts(@user)
  end
  
  def character
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :chara1, :chara2)
  end
  
end
