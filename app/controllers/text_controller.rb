class TextController < ApplicationController
  
  def receive
    incoming_number = params["From"][2..-1]
    user = User.find_by_number(incoming_number)
    
    if !user.nil?    
      message_body = params["Body"]
    
      if message_body[0..6].downcase == "update "
        argument = message_body[7..-1]
        completed_activity = nil
        user.activities.all.each do |activity|
          if activity.name.downcase == argument.downcase
            completed_activity = activity
            #break
          end
        end
        if !completed_activity.nil?
          completed_activity.update_attribute(:time, Time.now.getlocal.to_date)
          completed_activity.save
          Text.send_text_message("The task #{completed_activity.name} was successfully updated.", incoming_number)
          Pusher['taskreminder'].trigger('update', {})
          #send_status()
        else
          Text.send_text_message("Error - \'#{argument}\' was not recognized as a task. No tasks were updated. For a list of tasks, text the word \'tasks\'", incoming_number)
        end
      elsif message_body[0..4].downcase == "tasks"
        Text.send_task_list(incoming_number)
      elsif message_body[0..5].downcase == "status"
        Text.send_status(incoming_number)
      elsif message_body[0..7].downcase == "commands"
        message = "Commands:"
        message += "\n------------------------------\n"
        message += "update [task name]\n"
        message += "tasks\n"
        message += "status"
        Text.send_text_message(message, incoming_number)
      else
        Text.send_text_message("Invalid command. For a list of commands, text the word \'commands\'", incoming_number)
      end
    end
    render :xml => {:result => "OK"}.to_xml
    end
  
    def status
      user = User.find_by_id(session[:user_id])
      if !user.nil?
        Text.send_status(user.number)
      end
      redirect_to :controller => "home", :action => "index"
    end
    
    def remind
      user = User.find_by_id(session[:user_id])
      if !user.nil?
        Text.send_reminder(user.number)
      end
      redirect_to :controller => "home", :action => "index"
    end
    
    def overdue
      user = User.find_by_id(session[:user_id])
      if !user.nil?
        Text.send_overdue_reminders(user.number)
      end
      redirect_to :controller => "home", :action => "index"
    end
    
end
