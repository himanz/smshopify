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
   
    reply = Message.incoming_parse(params)
		twiml = Twilio::TwiML::Response.new do |r|
      r.Message reply
    end
    
    

    render_twiml twiml
	end

end
