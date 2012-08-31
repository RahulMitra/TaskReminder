class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :number
      t.string :username
      t.string :password_digest
      t.string :salt
      
      t.timestamps
    end
  end
end
