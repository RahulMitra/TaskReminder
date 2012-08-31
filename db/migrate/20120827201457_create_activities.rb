class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :user_id
      t.integer :time_out
      t.date :time
      t.boolean :text_message
      t.boolean :email

      t.timestamps
    end
  end
end