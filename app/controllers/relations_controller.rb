class RelationsController < ApplicationController
  
  before_action :login_confirmation
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = "ユーザーをフォローしました"
    redirect_to user
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = "ユーザーのフォローを解除しました"
    redirect_to user
  end
  
  
end
