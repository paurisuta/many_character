class PostsController < ApplicationController
  before_action :login_confirmation
  before_action :correct_user, only: [:destroy]
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "メッセージを投稿しました"
      redirect_to root_url
    else
      flash.now[:danger] = "メッセージの投稿に失敗しました"
      render "toppages/index"
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "メッセージを削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
end
