class HomeController < ApplicationController
  def index
    @activities = Activity.all
  end
  
  def add
    @activity = Activity.new
  end
  
  def post_add
    activity = Activity.new
    activity.name = params[:taskName]
    activity.time_out = params[:timeOut]
    activity.time = Date.strptime params[:lastCompleted], "%m/%d/%Y"
    
    if params[:textOption]
      activity.text_message = true
    else
      activity.text_message = false
    end
    
    if params[:emailOption]
      activity.email = true
    else
      activity.email = false
    end
      
    activity.save
    
    Pusher['taskreminder'].trigger('update', {})
    redirect_to :controller => 'home', :action => 'index'
  end
  
  def post_edit
    activity = Activity.find_by_id(params[:id])
    activity.name = params[:taskName]
    activity.time_out = params[:timeOut]
    activity.time = Date.strptime params[:lastCompleted], "%m/%d/%Y"
    
    if (params[:textOption])
      activity.text_message = true
    else
      activity.text_message = false
    end
    
    if (params[:emailOption])
      activity.email = true
    else
      activity.email = false
    end
    
    activity.save
    Pusher['taskreminder'].trigger('update', {})
    redirect_to :controller => 'home', :action => 'index'
    
  end
  
  def post_delete
    activity = Activity.find_by_id(params[:id])
    activity.delete
    Pusher['taskreminder'].trigger('update', {})
    redirect_to :controller => 'home', :action => 'index'
  end
  
  def post_update
    activity = Activity.find_by_id(params[:id])
    activity.update_attribute(:time, Time.now.getlocal.to_date)
    activity.save
    Pusher['taskreminder'].trigger('update', {})
    redirect_to :controller => 'home', :action => 'index'
  end
  
  def login

  end

  def post_login    
    if(@user.nil?)  
      flash[:message] = "Invalid Username"
      redirect_to :back      
    elsif @user.password_valid?(params[:user][:password])      
        session[:username] = params[:user][:login]
        session[:id] = @user.id
        session[:firstName] = @user.first_name
        redirect_to :controller => "user", :action => "profile", :id => @user.id
    else
        flash[:message] = "Incorrect Password"
        redirect_to :back  
    end 
  end
  
end
