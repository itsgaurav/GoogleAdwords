class KeywordsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    redirect_to :controller => "home",:action => "index"
  end

  def create
    if params[:file].present?
      if params[:file].content_type == 'text/csv'
        parser = CsvParser.new(params[:file].tempfile)
        content = parser.read
        validated_content = parser.verify_keywords(content)
        render json: { code: 500, message: validated_content[:message], result: "unable to validate content of csv" } and return unless validated_content[:status]
        GoogleSearchJob.perform_later(validated_content[:keywords], current_user.id)
        redirect_to :controller => "home",:action => "index"
      else
        render json: { code: 500, message: "message", result: "error" } and return
      end
    else
      render json: { code: 500, message: "message", result: "keywords error" } and return
    end
  end

  def show
    @keyword = current_user.user_keywords.find_by_id(params[:id])
  end
end
