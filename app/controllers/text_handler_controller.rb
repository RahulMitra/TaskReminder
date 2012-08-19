class TextHandlerController < ApplicationController
  def index
  end
  
  def receive
    @number = "+14807348445"
    message_body = params["Body"]
    incoming_number = params["From"]
    
    if incoming_number == @number
      send_text_message("Hi")
    end
  end
  
end
