class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  def login_confirmation
    redirect_to login_path unless logged_in?
  end
  
end
