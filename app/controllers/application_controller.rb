class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  def login_confirmation
    redirect_to login_path unless logged_in?
  end
  
  def counts(user)
    @count_posts = user.posts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likings = user.likings.count
  end
  
end
