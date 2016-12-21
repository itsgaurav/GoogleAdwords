class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
		@keywords = current_user.user_keywords
		access_token = Doorkeeper::AccessToken.find_or_create_for(nil,current_user.id,nil,5040,true)
	end

end