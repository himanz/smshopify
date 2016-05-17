class MessagesController < ApplicationController
	include Webhookable
  # after_filter :set_header
  
	skip_before_action :verify_authenticity_token

	def index
		@client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_auth_token"]

    @messages = @client.account.messages.list
  end

	def inbound
    sender = params[:From]
    
		twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hey there! I got a text from you. #{sender}"
    end

    render_twiml twiml
	end

end
