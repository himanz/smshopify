class MessagesController < ApplicationController
	def grab
	  twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Jonos, this works!"
    end
    twiml.text
  end
end
