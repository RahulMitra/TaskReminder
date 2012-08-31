class ActivityController < ApplicationController
  
  def post_add
    activity = Activity.new
    activity.name = params[:new][:task_name]
    activity.time_out = params[:new][:time_out]
    activity.time = Date.strptime params[:new][:last_completed], "%m/%d/%Y"
    
    if params[:new][:text_option] == "1"
      activity.text_message = true
    else
      activity.text_message = false
    end
    
    if params[:new][:email_option] == "1"
      activity.email = true
    else
      activity.email = false
    end
    
    activity.user_id = session[:user_id]
    activity.save
    
    redirect_to :controller => 'home', :action => 'index'
    Pusher['taskreminder'].trigger('update', {})
  end
  
  def post_edit
    activity = Activity.find_by_id(params[:edit][:id])
    activity.name = params[:edit][:task_name]
    activity.time_out = params[:edit][:time_out]
    activity.time = Date.strptime params[:edit][:last_completed], "%m/%d/%Y"
    
    if params[:edit][:text_option] == "1"
      activity.text_message = true
    else
      activity.text_message = false
    end
    
    if params[:edit][:email_option] == "1"
      activity.email = true
    else
      activity.email = false
    end
    
    activity.save
    redirect_to :controller => 'home', :action => 'index'
    Pusher['taskreminder'].trigger('update', {})
  end
  
  def post_update
    activity = Activity.find_by_id(params[:id])
    activity.update_attribute(:time, Time.now.getlocal.to_date)
    activity.save
    redirect_to :controller => 'home', :action => 'index'
    Pusher['taskreminder'].trigger('update', {})
  end
  
  def post_delete
    activity = Activity.find_by_id(params[:edit][:id])
    activity.delete
    redirect_to :controller => 'home', :action => 'index'
    Pusher['taskreminder'].trigger('update', {})
  end
end
