class UserController < ApplicationController
    
  def post_login   
    user = User.find_by_username(params[:login][:input]) || User.find_by_number(params[:login][:input])
     
    if(user.nil?)  
      flash[:message] = "Invalid Username"
      redirect_to :back      
    elsif user.password_valid?(params[:login][:password])      
      session[:user_id] = user.id
      redirect_to :controller => "home", :action => "index"
    else
      flash[:message] = "Incorrect Password"
      redirect_to :back 
    end 
  end
  
  def logout
    reset_session
    redirect_to :controller => "home", :action => "index"
  end
  
  def register
    if !session[:user_id].nil?
      redirect_to :controller => "home", :action => "index"
    else
      @user = User.new
    end
  end
  
  def post_register
    if @user = User.create(params[:user])
      Text.send_text_message("Thank you for signing up for task reminder, #{@user.first_name}! This number has been successfully linked to your task reminder account.", @user.number)
      flash[:notice] = "Account Successfully Created!"
      session[:user_id] = @user.id
      redirect_to :controller => "home", :action => "index"
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to :controller => "user", :action => "login"
    end
  end
  
  def post_delete
    user = User.find_by_id(session[:user_id])
    user.delete
    redirect_to :controller => "user", :action => "login"
    reset_session
  end
  
  def edit
    @user = User.find_by_id(session[:user_id])
  end
    
  def post_edit
    @user = User.find_by_id(session[:user_id])    
    if @user.update_attributes(params[:user])
      redirect_to :controller => "home", :action => "index"
    else
      # error handling
    end
  end
  
  def post_delete
    user = User.find_by_id(session[:user_id])
    user.activities.all.each do |activity|
      activity.delete
    end
    user.delete
    reset_session
    redirect_to :controller => 'user', :action => 'login'
  end
end
