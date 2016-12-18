class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
		@keywords = current_user.user_keywords
	end

end