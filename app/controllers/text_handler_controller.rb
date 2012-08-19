class TextHandlerController < ApplicationController
  def index
  end
  
  def receive
    message_body = params["Body"]
    from_number = params["From"]
    
    message = "You said #{message_body} from #{from_number}"
    send_text_message(message)
  end
  
end
