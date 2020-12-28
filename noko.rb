require 'open-uri'
require 'nokogiri'
require 'csv'

url = 'https://qiita.com/search?page=1&q=ruby&sort=like'


charset = nil


html = open(url) do |f|
	charset = f.charset
	f.read
end


doc = Nokogiri::HTML.parse(html, nil, charset)



results = []

doc.css(".searchResult_main").each do |node|
	tags = []
	title = node.css("h1.searchResult_itemTitle").text
	node.css(".tagList_item").each{ |article_tag|  tags << article_tag.text }
	details = node.css(".searchResult_snippet").text
	results << [title, tags, details]
end


results.each_with_index do |result, i|
	puts "#{i+1}番目の検索結果"
	puts "Title: #{result[0]}"
	puts "Tags: #{result[1]}"
	puts "Details: #{result[2]}"
	puts "----------------------"
end


