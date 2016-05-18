class MessagesController < ApplicationController
	include Webhookable
  # after_filter :set_header
  enable :sessions
  
	skip_before_action :verify_authenticity_token

	def index
		@client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_auth_token"]

    @messages = @client.account.messages.list

  end

	def inbound
    session["counter"] ||= 0
    sms_count = session["counter"]
    if sms_count == 0
    	puts "TESTING"
    else
    	puts "OVER 9000"
    end
    reply = Message.incoming_parse(params)
		twiml = Twilio::TwiML::Response.new do |r|
      r.Message reply
    end
    
    session["counter"] += 1

    render_twiml twiml
	end

end
