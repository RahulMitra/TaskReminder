class TextHandlerController < ApplicationController
  def index
  end
  
  def receive
    @number = "+14807348445"
    message_body = params["Body"]
    from_number = params["From"]
    
    if params["From"] == @number
      message = "Hello Rahul"
      send_text_message(message)
    end
  end
  
end
