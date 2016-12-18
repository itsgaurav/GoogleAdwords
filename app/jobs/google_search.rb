class GoogleSearch < ActiveJob::Base
  queue_as :default

  def perform(keywords, user_id)
    keywords.each do |keyword|
      data = GoogleSearch.new(keyword).result
      User.find_by_id(user_id).user_keywords.create!(data)
    end
  end
end
