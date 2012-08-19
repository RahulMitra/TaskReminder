desc "This task is called by the Heroku scheduler add-on"
task :send_reminders => :environment do
  text = TextHandlerController.new
  text.send_text_message
end