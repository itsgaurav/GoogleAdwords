class V1::KeywordsController < V1::ApiApplicationController
  
  protect_from_forgery with: :null_session, only: [:create]

  def index
    keywords = current_user.user_keywords
    render :json => keywords, :except => [:raw_html,:updated_at]
  end

  def create
    if params[:file].present?
      if params[:file].content_type == 'text/csv'
        parser = CsvParser.new(params[:file].tempfile)
        content = parser.read
        validated_content = parser.verify_keywords(content)
        render json: { code: 500, message: validated_content[:message], result: "unable to validate content of csv" } and return unless validated_content[:status]
        GoogleSearchJob.perform_later(validated_content[:keywords], current_user.id)
        render json: { code: 200, message: "Success", result: "Result generated successfully" } and return
      else
        render json: { code: 500, message: "Incorrect File type", result: "File type error" } and return
      end
    else
      render json: { code: 500, message: "Empty File", result: "File error" } and return
    end
  end
end
