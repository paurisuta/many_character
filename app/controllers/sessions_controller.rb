class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.find_by(email: session_params[:email])
    
    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      flash[:success] = "ログインに成功しました"
      redirect_to @user
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
    
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
  
  private
  
  def session_params
    params.require(:session).permit(:email, :password)
  end
  
  
end
