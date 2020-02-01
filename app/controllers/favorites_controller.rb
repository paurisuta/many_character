class FavoritesController < ApplicationController
  
  before_action :login_confirmation
  
  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    flash[:success] = "投稿をお気に入りに追加しました"
    redirect_to current_user
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlike(post)
    flash[:danger] = "投稿のお気に入りを解除しました"
    redirect_to current_user
  end
  
  
  
end
