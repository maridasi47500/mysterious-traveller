User.destroy_all
date=Date.today-18.years - 1.day
(1..50).to_a.each do |i|
User.create({gender: "1",
email:"aa@aa#{i}",
dateofbirth: date,
name:"user1#{i}",
password:"1111111#{i}"})
end
##User.where(dateofbirth:nil).update_all(dateofbirth: "01-01-1990")
##
##
#Relationship.destroy_all
#Relationship.create(name: 'Friendly')
#Relationship.create(name: 'Serious')
#Relationship.create(name: 'Fun')
###37Emojis
#Emoji.destroy_all
##1
#Emoji.create(code: "\\1F600")
#Emoji.create(code: "\\1F603")
#Emoji.create(code: "\\1F604")
#Emoji.create(code: "\\1F601")
#Emoji.create(code: "\\1F606")
#Emoji.create(code: "\\1F605")
#Emoji.create(code: "\\1F923")
#Emoji.create(code: "\\1F602")
#Emoji.create(code: "\\1F642")
#Emoji.create(code: "\\1F643")
##10
#Emoji.create(code: "\\1FAE0")
#Emoji.create(code: "\\1F609")
#Emoji.create(code: "\\1F60A")
#Emoji.create(code: "\\1F607")
#Emoji.create(code: "\\1F970")
#Emoji.create(code: "\\1F60D")
#Emoji.create(code: "\\1F60B")
#Emoji.create(code: "\\1F61B")
#Emoji.create(code: "\\1F61C")
#Emoji.create(code: "\\1F917")
##20
#Emoji.create(code: "\\1F92D")
#Emoji.create(code: "\\1F910")
#Emoji.create(code: "\\1F928")
#Emoji.create(code: "\\1F610")
#Emoji.create(code: "\\1F611")
#Emoji.create(code: "\\1F636")
#Emoji.create(code: "\\1F60C")
#Emoji.create(code: "\\1F614")
#Emoji.create(code: "\\1F62A")
#Emoji.create(code: "\\1F924")
##30
#Emoji.create(code: "\\1F48C")
#Emoji.create(code: "\\1F498")
#Emoji.create(code: "\\1F496")
#Emoji.create(code: "\\FE0F")
#Emoji.create(code: "\\2764")
#Emoji.create(code: "\\1F494")
#Emoji.create(code: "\\1F495")
