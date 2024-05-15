require "nokogiri"
require "open-uri"
@comptdate=-30
@comptdesc=-30
OrthodoxHoroscope.delete_all
@doc3 = Nokogiri::HTML(File.read("./zodiac3.html"))

@doc3.css(".single__content")[0].children.select{|h|h.name != "text" }.each do |div|
p div
@comptdate=@comptdate - 1
@comptdesc=@comptdesc - 1

p "test si il y a la description"
if @comptdesc==0
desc=div.text
p desc
@sign.update(description: desc)
end

p "teste si il y a les dates"
if @comptdate==0

p div.text.gsub('(','').gsub(')','')
dates=div.text.gsub('(','').gsub(')','').split('–')
mybegin=dates[0].strip.squish+" 2022"
myend=dates[1].strip.squish+" 2022"
@sign.update(begin: mybegin,end:myend)
end

if div.name == "h2"
@comptdate=1
@comptdesc=8
@sign=OrthodoxHoroscope.find_or_create_by(name: div.text.strip.squish.titleize)
end

end
h=OrthodoxHoroscope.find_by(name: "Libra")
h.update(celebrities: "Cardi B")
h=OrthodoxHoroscope.find_by(name: "Leo")
h.update(celebrities: "Madonna")
h=OrthodoxHoroscope.find_by(name: "Cancer")
h.update(celebrities: "Ariana Grande")
h=OrthodoxHoroscope.find_by(name: "Gemini")
h.update(celebrities: "Angelina Jolie")
h=OrthodoxHoroscope.find_by(name: "Scorpio")
h.update(celebrities: "Hilary Clinton, Katy Perry")
h=OrthodoxHoroscope.find_by(name: "Aries")
h.update(celebrities: "Lady Gaga, Emma Watson")
h=OrthodoxHoroscope.find_by(name: "Virgo")
h.update(celebrities: "Beyoncé, Pink")
h=OrthodoxHoroscope.find_by(name: "Taurus")
h.update(celebrities: "Adele, Aya Nakamura")
h=OrthodoxHoroscope.find_by(name: "Pisces")
h.update(celebrities: "Rihanna, Elliott Page")
h=OrthodoxHoroscope.find_by(name: "Aquarius")
h.update(celebrities: "Bob Marley, Ellen DeGeneres, Harry Styles, Ed Sheeran")
h=OrthodoxHoroscope.find_by(name: "Capricorn")
h.update(celebrities: "Michelle Obama, Elvis Presley")
h=OrthodoxHoroscope.find_by(name: "Sagittarius")
h.update(celebrities: "Sia, Britney Spears, Miley Cyrus")