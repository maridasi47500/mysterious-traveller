require 'nokogiri'

doc=Nokogiri::HTML(File.read('./codeinterests.html'))
doc.css('.interests').children.each do |j|
k=j.css('label').text
l = Interest.find_or_create_by(name: k)
end
