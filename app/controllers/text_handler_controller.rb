class TextHandlerController < ApplicationController
  def index
  end
  
  def receive
    @number = "+14807348445"
    incoming_number = params["From"]
    message_body = params["Body"]
    
    if incoming_number == @number
      if message_body[0..6].downcase == "update "
        argument = message_body[7..-1]
        completed_activity = Activity.find_by_name(argument)
        if !completed_activity.nil?
          id = completed_activity.id
          redirect_to :controller => 'home', :action => 'post_update', :id => id
          send_text_message("The task #{completed_activity.name} was successfully updated.")
        else
          send_text_message("Error - \'#{argument}\' was not recognized as a task. No tasks were updated. For a list of tasks, text the word \'tasks\'")
        end
      elsif message_body[0..4].downcase == "tasks"
        send_list()
      elsif message_body[0..5].downcase == "status"
        send_status()
      elsif message_body[0..7].downcase == "commands"
        message = "Commands:"
        message += "\n------------------------------\n"
        message += "update [task name]\n"
        message += "tasks\n"
        message += "status"
        send_text_message(message)
      else
        send_text_message("Invalid command. For a list of commands, text me the word \'commands\'")
      end
    end
  end
  
  def test
    
  end
  
end
