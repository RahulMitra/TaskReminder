module ApplicationHelper
  def submit_tag_to_action(value, action, options={})
    submit_tag(value, options.merge!(:onclick => "this.form.action='#{action}'"))
  end
  
  def format_number(number)    
    return number_to_phone(number, :groupings => [3, 3, 4], :delimiter => "-")
  end
  
  def formatDay(timeStamp)
    return timeStamp.to_datetime.strftime("%A, %b %d")
  end
  
  def formatTime(timeStamp)
    return timeStamp.to_datetime.strftime("%l:%M%P")
  end
end
