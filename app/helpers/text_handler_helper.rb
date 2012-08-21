module TextHandlerHelper
  
  def send_status
    sorted_activities = Activity.all.sort { |a,b| (Time.now.getlocal.to_date.mjd - b.time.mjd) - b.time_out <=>
														(Time.now.getlocal.to_date.mjd - a.time.mjd) - a.time_out }
		
		message = "Status:"
		message += "\n------------------------------"						
 		sorted_activities.each do |activity|
 		  days_since_completion = Time.now.getlocal.to_date.mjd - activity.time.mjd
			days_overdue = days_since_completion - activity.time_out		
			
			message += "\n#{activity.name.upcase} "
			if days_overdue < 0
			  if days_overdue == -1
			    message += "is due tomorrow."
		    else
		      message += "is due in #{days_overdue.abs} days."
	      end
      else
        if days_overdue == 0
          message += "is due today."
        elsif days_overdue == 1
          message += "was due yesterday."
        else
          message += "was due #{days_overdue} days ago."
        end
      end
    end
    send_long_text(message)
  end
  
  def send_reminders
    header_sent = false
		reminder_count = 0
		
		sorted_activities = Activity.all.sort { |a,b| (Time.now.getlocal.to_date.mjd - b.time.mjd) - b.time_out <=>
														(Time.now.getlocal.to_date.mjd - a.time.mjd) - a.time_out }
		
		message = ""
 		sorted_activities.each do |activity|
        days_since_completion = Time.now.getlocal.to_date.mjd - activity.time.mjd
  			days_overdue = days_since_completion - activity.time_out		
  			
  			if days_overdue >= 0 && activity.text_message
  			  reminder_count = reminder_count + 1
  			  if (!header_sent)
  			    header_message = "Reminders for #{formatDayNicely(Time.now.getlocal)}\n"
  			    header_message += "------------------------------"
  			    message += header_message
  			    header_sent = true
			    end
  			  message += "\n#{reminder_count}. #{activity.name.upcase} "
          if days_overdue == 0
            message += "is due today."
          elsif days_overdue == 1
            message += "was due yesterday."
          else
            message += "was due #{days_overdue} days ago."
          end
        end
    end
    
    if message.length != 0
      send_long_text(message)
    end
  end
  
  def send_overdue_reminders
		sorted_activities = Activity.all.sort { |a,b| (Time.now.getlocal.to_date.mjd - b.time.mjd) - b.time_out <=>
														(Time.now.getlocal.to_date.mjd - a.time.mjd) - a.time_out }
 		sorted_activities.each do |activity|
        days_since_completion = Time.now.getlocal.to_date.mjd - activity.time.mjd
  			days_overdue = days_since_completion - activity.time_out		
  			
  			if days_overdue >= 1 && activity.text_message
  			  message = "The following task is OVERDUE:\n\n"
  			  message += "#{activity.name.upcase}"
  			  message += "\n------------------------------\n"
  			  if days_overdue == 1
            message += "Was due yesterday."
          else
            message += "Was due #{days_overdue} days ago."
          end
          message += "\nLast completed #{days_since_completion} days ago."
          send_text_message(message)
          sleep 3.0
        end
    end
  end  
  
  def send_task_list()
    list = ""
    Activity.all.each do |activity|
      list += "\n#{activity.name}"
    end
    
    if list.size == 0
      send_text_message("You have no tasks in the system!")
    else
      message = "The following tasks are in the system:"
      message += "\n------------------------------"
      message += list
      send_long_text(message)
    end
  end
  
  def send_text_message(message)
    #twilio_sid = TWILIO_CONFIG['sid']
    #twilio_token = TWILIO_CONFIG['token']
    #twilio_phone_number = TWILIO_CONFIG['from']
    twilio_sid = "ACd134e637ea9351e54eb8da2f3599e363"
    twilio_token = "b6d1bc1f4ba622e28378217432445366"
    twilio_phone_number = "6027345137"
    number_to_send_to = "4807348445"

    twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)    
    twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => message
    )
  end
  
  def send_long_text(long_message)
    num_characters = 160
    message = long_message
    while message.length > num_characters
      send_text_message(message[0..num_characters])
      sleep 3.0
      message = message[num_characters+1..-1]
    end
    send_text_message(message)
  end
  
  def formatDayNicely(timeStamp)
    return timeStamp.to_datetime.strftime("%A, %b %d")
  end

end
