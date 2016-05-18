class MessagesController < ApplicationController
	include Webhookable
  # after_filter :set_header
  
	skip_before_action :verify_authenticity_token

	def index
		@client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_auth_token"]

    @messages = @client.account.messages.list

  end

	def inbound
    @user = User.find_or_create_by(from: params["From"])
    # reply = Message.incoming_parse(params)
    if @user.step == 1
      reply = Message.menu
      @user.step += 1
    elsif @user.step == 2
    	if params["Body"] == "1"
    	  reply = Message.enter_product_id
    	  @user.step += 1
    	end
    end
		twiml = Twilio::TwiML::Response.new do |r|
      r.Message reply
    end
    
    render_twiml twiml
	end

end
