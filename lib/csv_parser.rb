require 'csv'

class CsvParser

  attr_reader :file
  
  def initialize file
    @file = file
  end

  def read
    begin
      CSV.read(@file).flatten
    rescue
      []
    end
  end

  def verify_keywords(keywords)
    num_keywords = keywords.count
    status = false
    message = 
      if num_keywords.zero?
        I18n.t('csv_parser.error.empty')
      elsif num_keywords > 1000
        I18n.t('csv_parser.error.too_large_exception')
      elsif keywords.include? nil
        I18n.t('csv_parser.error.incorrect_content')
      else
        status = true
        I18n.t('csv_parser.success')
      end
    {
      message: message,
      keywords: keywords,
      status: status
    }
  end
end
