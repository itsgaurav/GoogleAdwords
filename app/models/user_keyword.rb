class UserKeyword < ActiveRecord::Base
  belongs_to :user

  validates :user, :keyword,
    :top_adwords_count, :right_adwords_count, :total_adwords_count,
    :non_adwords_count, :total_link_count,
    :raw_html, presence: true

  scope :order_by_keyword_asc, -> { order('keyword asc') }
end
