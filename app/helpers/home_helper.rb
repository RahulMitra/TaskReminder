module HomeHelper
  
  def formatDay(timeStamp)
    return timeStamp.to_datetime.strftime("%A, %b %d")
  end
  
  def formatTime(timeStamp)
    return timeStamp.to_datetime.strftime("%l:%M%P")
  end

end
