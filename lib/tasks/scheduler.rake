desc "Sends a compiled list of tasks due today or overdue."
task :remind => :environment do
  Text.send_reminder("4807348445")
end

desc "Sends individual reminders for each overdue task."
task :nag => :environment do
  Text.send_overdue_reminders("4807348445")
end

desc "Sends the status of all tasks in system."
task :status => :environment do
  Text.send_status("4807348445")
end

desc "Sends the names of all tasks in system."
task :list => :environment do
  Text.send_task_list("4807348445")
end