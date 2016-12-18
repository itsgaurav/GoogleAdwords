class CreateKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :user_keywords do |t|
    	t.belongs_to  :user
      t.string      :keyword, null: false, default: ''
      t.integer     :top_adwords_count, null: false, default: 0
      t.integer     :bottom_adwords_count, null: false, default: 0
      t.integer     :total_adwords_count, null: false, default: 0
      t.integer     :non_adwords_count, null: false, default: 0
      t.integer     :total_link_count, null: false, default: 0
      t.text      :top_adword_urls, null: false, array: true
      t.text      :bottom_adword_urls, null: false, array: true
      t.text      :non_adword_urls, null: false, array: true
      t.text      :total_search_result, null: false, array: true
      t.text        :raw_html, null: false
      t.timestamps   null: false
    end
  end
end
