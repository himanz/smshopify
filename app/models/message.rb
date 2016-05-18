class Message < ActiveRecord::Base
	def self.incoming_parse(params)
		sender = params[:From]
		if params[:Body] == "Test"
			return "I am returning Test"
		else
			return "Hey there! I got a text from you. #{sender}"
		end
	end

	def self.menu
		return "Menu\n
		        1. Get a product\n
		        2. To be annouced"
	end
end
