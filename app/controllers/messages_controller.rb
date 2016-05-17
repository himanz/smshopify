class MessagesController < ApplicationController
	include Webhookable
  # after_filter :set_header
  
	skip_before_action :verify_authenticity_token

	enable :sessions

	def index
		@client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_auth_token"]

    @messages = @client.account.messages.list
  end

	def inbound
		session["counter"] ||= 0
    sms_count = session["counter"]
    sender = params[:From]
    
		twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hey there! I got a text from you. #{sender}. Message number #{sms_count + 1}"
    end

    session["counter"] += 1
    render_twiml twiml
	end

end
