class Message < ActiveRecord::Base
	def incoming_parse
		if params["body"] == "Test"
			return "I am returning Test"
		else
			return "Hey there! I got a text from you. #{sender}"
		end
	end
end
