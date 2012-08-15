class LoadData < ActiveRecord::Migration
  def change
    one = Activity.new
    one.name = "Chest & Triceps"
    one.time = Time.now.getlocal.to_date
    one.time_out = 4;
    one.text_message = true;
    one.email = false;
    one.save
    
    two = Activity.new
    two.name = "Back & Biceps"
    two.time = Time.now.getlocal.to_date
    two.time_out = 4;
    two.text_message = true;
    two.email = false;
    two.save
    
    three = Activity.new
    three.name = "Cardio"
    three.time = Time.now.getlocal.to_date
    three.time_out = 4;
    three.text_message = true;
    three.email = false;
    three.save
    
    four = Activity.new
    four.name = "Abs & Obliques"
    four.time = Time.now.getlocal.to_date
    four.time_out = 4;
    four.text_message = true;
    four.email = false;
    four.save
    
    five = Activity.new
    five.name = "Shower"
    five.time = Time.now.getlocal.to_date
    five.time_out = 2;
    five.text_message = true;
    five.email = false;
    five.save
  end
end
