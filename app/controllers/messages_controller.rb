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
    
    shop_url = "https://#{ENV["shopify_api_key"]}:#{ENV["shopify_password"]}@chef-curry.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url

    if params["Body"] == "reset"
    	@user.step = 1
    end
    if @user.step == 1
      if params["Body"] == "1"
      	reply = Message.enter_product_id
        @user.step += 1
        @user.save
      else
      	reply = Message.menu
      end
    elsif @user.step == 2
    	product = ShopifyAPI::Product.find(params["Body"])
    	if product == nil
    	  reply = Message.enter_product_id
    	else
    	  reply = product.title
    	end
    end
		twiml = Twilio::TwiML::Response.new do |r|
      r.Message reply
    end
    
    render_twiml twiml
	end

end
