class MessagesController < ApplicationController
	def index
		twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hey there! I got a text from you."
    end
    twiml.text

    

	end

	def inbound
	end
end
