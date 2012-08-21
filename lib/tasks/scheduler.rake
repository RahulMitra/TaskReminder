desc "This task is called by the Heroku scheduler add-on. It sends the daily reminder list."
task :remind => :environment do
  send_text = TextHandlerController.new
  send_text.remind()
end

desc "This task is called by the Heroku scheduler add-on. It sends out extra naggy reminders."
task :nag => :environment do
  send_text = TextHandlerController.new
  send_text.nag()
end