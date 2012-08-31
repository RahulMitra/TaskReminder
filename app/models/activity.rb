class Activity < ActiveRecord::Base
  attr_accessible :name, :time_out, :time, :text_message, :email
  belongs_to :user
end
