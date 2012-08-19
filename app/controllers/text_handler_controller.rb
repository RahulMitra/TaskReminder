class TextHandlerController < ApplicationController
  def index
  end
  
  def receive
    @number = "+14807348445"
    incoming_number = params["From"]
    message_body = params["Body"]
    
    if incoming_number == @number
      if message_body[0..4].downcase == "update "
        argument = message_body[5..-1].downcase
        completed_activity = Activity.find_by_name(argument)
        if !completed_activity.nil?
          id = completed_activity.id
          redirect_to :controller => 'home', :action => 'post_update', :id => id
          send_text_message("The task #{completed_activity.name} was successfully updated.")
        else
          send_text_message("Error - #{argument} was not recognized as a task. No tasks were updated.")
        end
      elsif message_body[0..3].downcase == "list"
        send_list()
      elsif message_body[0..5].downcase == "status"
        send_status()
      elsif message_body[0..3].downcase == "help"
        message = "help:"
        send_text_message(message)
      else
        send_text_message("Invalid command. For a list of commands, text me the word help")
      end
    end
  end
  
  def test
    
  end
  
end
