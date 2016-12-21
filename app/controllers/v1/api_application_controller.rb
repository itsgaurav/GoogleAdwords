class V1::ApiApplicationController < ApplicationController
	before_action :doorkeeper_authorize!

  def current_user
    @current_user ||= User.find_by_id(
      doorkeeper_token.resource_owner_id
      ) unless doorkeeper_token.nil?
  end

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: "Not authorized" } }
  end
end
