class HomeController < ApplicationController
  def index
    if session[:user_id].nil?
      redirect_to :controller => 'user', :action => 'login'
    else
      @user = User.find_by_id(session[:user_id])
      @activities = @user.activities
    end
  end
  
end