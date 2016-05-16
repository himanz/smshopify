class MessagesController < ApplicationController
	include Webhookable
  after_filter :set_header
  
	skip_before_action :verify_authenticity_token
	def index
		

    

	end

	def inbound
		twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hey there! I got a text from you."
    end
    render_twiml twiml
	end
end
