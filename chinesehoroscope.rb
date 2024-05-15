require "nokogiri"
require "open-uri"
ChineseHoroscope.delete_all
ChineseHoroscopeDate.delete_all
arr=['Ox','Sheep','Ray','Snake','Dragon','Tiger','Rabbit','Horse','Monkey','Rooster','Dog','Pig']
arr.each {|h|ChineseHoroscope.find_or_create_by(name: h)}
p "===date====="
#date
begin
#@doc = Nokogiri::HTML(File.read("https://www.travelchinaguide.com/intro/chinese-zodiac-years-chart.htm"))
@doc3 = Nokogiri::HTML(File.read("./zodiac1.html"))
@doc3.css("tr").each do |line|
p line.text
if line.css('td').length == 3
@sign=ChineseHoroscope.find_or_create_by(name: line.css('td')[2].text.split(' ')[1].gsub('Goat','Sheep'))
p line.css('td')[0].text.split('–')[0]
p line.css('td')[0].text.split('–')[1]
p line.css('td')[1].text.split('–')[0]
p line.css('td')[1].text.split('–')[1]
p line.css('td')[2].text.split('–')[0]
p line.css('td')[2].text.split('–')[1]
ChineseHoroscopeDate.find_or_create_by(chinese_horoscope_id: @sign.id, "begin" => line.css('td')[1].text.split('–')[0].strip.squish, "end" => line.css('td')[1].text.split('–')[1].squish)
end
end
rescue
end

p "===lucky numbers====="
#lucky numbers
@doc=Nokogiri::HTML(URI.open("https://www.chinahighlights.com/travelguide/chinese-zodiac/"))
@doc.css('table').select{|g|g.text.include?('Lucky Numbers')}[0].css('tr').each do |ligne|
if @sign=ChineseHoroscope.find_by(name: ligne.css('th').text.gsub('Goat','Sheep'))
@sign.update(lucky_numbers: ligne.css('td')[0].text)
end
end

p "===description====="
#description
begin
#@doc=Nokogiri::HTML(URI.open("https://www.travelchinaguide.com/intro/social_customs/zodiac/"))
@doc=Nokogiri::HTML(File.read("./zodiac2.html"))
@doc.css('.g_tab_item').each do |t|
@sign=ChineseHoroscope.find_by_name(t.css('.divEachTitle')[0].text.split(' ')[0].gsub('Goat','Sheep'))
@sign.update(description: t.inner_html.split('</div>')[1].split('<b>')[0])
end
rescue
end
p "===pros and cons====="
#pros and cons
@doc=Nokogiri::HTML(URI.open("https://her.womenworking.com/12-chinese-zodiac-signs-reveal-personality"))
(0..11).to_a.each do |t|
p @doc.css("h2")[t].text
@sign=ChineseHoroscope.find_by_name(@doc.css("h2")[t].text.split(' ')[1].gsub('Goat','Sheep'))
@sign.update(pro: @doc.css('p').select{|h|h.text.include?("Strength")}[t].text.gsub('Strengths: ','').gsub('Strength: ',''), con: @doc.css('p').select{|h|h.text.include?("Weakness")}[t].text.gsub('Weaknesses: ','').gsub('Weakness: ',''))
end
