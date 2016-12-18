require 'open-uri'
require 'nokogiri'

class GoogleSearch
  attr_reader :keyword, :document, :file

  def initialize(keyword)
    @keyword = keyword
  end

  def open_search_page
    @file = open("https://www.google.com/search?q=#{@keyword}")
    @document = Nokogiri::HTML(@file)
  end
  
  def adwords_div_container
    @document.css('._AK')
  end

  def total_adwords_count
    adwords_div_container.count
  end

  def top_adwords
    adwords = adwords_div_container.at_css('#_Ltg')
    if adwords.nil?
      []
    else
      adwords.css('.ads-visurl ._WGk')
    end
  end

  def top_adwords_count
    top_adwords.count
  end

  def bottom_adwords
    adwords = adwords_div_container.at_css('#_Ktg')
    if adwords.nil?
      []
    else
      adwords.css('.ads-visurl ._WGk')
    end
  end

  def bottom_adwords_count
    bottom_adwords.count
  end

  def non_adwords
    non_adwords = @document.at_css('#res').at_css('#ires')
    if non_adwords.nil?
      []
    else
      non_adwords.css('.g')
    end
  end

  def non_adwords_count
    non_adwords.count
  end

  def total_link_count
    @document.css('a').count
  end

  def top_adword_urls
    top_adwords.map(&:inner_text).flatten
  end

  def bottom_adword_urls
    bottom_adwords.map(&:inner_text).flatten
  end

  def non_adword_urls
    non_ad_link = []
    non_adwords.css('cite').map(&:inner_text).flatten
  end

  def total_search_result
    result_status = @document.at_css('#resultStats')
    if result_status.blank?
      ''
    else
      result_status.inner_text
    end
  end

  def raw_html
    code = File.read(@file)
    if code.valid_encoding?
      code
    else
      code.scrub("?")
    end
  end

  def result
    open_search_page
    {
      keyword: @keyword,
      total_adwords_count: total_adwords_count,
      top_adwords_count: top_adwords_count,
      bottom_adwords_count: bottom_adwords_count,
      non_adwords_count: non_adwords_count,
      total_link_count: total_link_count,
      top_adword_urls: top_adword_urls,
      bottom_adword_urls: bottom_adword_urls,
      non_adword_urls: non_adword_urls,
      total_search_result: total_search_result,
      raw_html: raw_html,
    }
  end
end
