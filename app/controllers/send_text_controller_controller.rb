class SendTextControllerController < ApplicationController
  def index
  end

  def send_text_message
    @twilio_sid = "abc123"
    @twilio_token = "foobar"
    number_to_send_to = "4807348445"
    twilio_phone_number = "6027345137"
    text_message = params[:message]

    @twilio_client = Twilio::REST::Client.new(@twilio_sid, @twilio_token)

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => text_message
    )
  end
end
