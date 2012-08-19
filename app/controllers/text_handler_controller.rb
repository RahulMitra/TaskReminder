class TextHandlerController < ApplicationController
  def index
  end
  
  def receive
    send_status()
  end
  
end
