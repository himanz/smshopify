class User < ActiveRecord::Base
	validates_uniqueness_of :from
	before_create :set_default_step

	def set_default_step
		self.step = 1
	end
end
