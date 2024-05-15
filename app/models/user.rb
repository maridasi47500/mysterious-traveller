class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
has_many :outmsgs, class_name:"Message", foreign_key: :sender_id 
has_many :inmsgs, class_name:"Message", foreign_key: :receiver_id
attr_accessor :first, :nbconnected,:next,:previous,:mylength,:myoffset,:searchnewconnected,:range_1, :range_2, :chattername, :IsGops, :WantsToRegister,:serious,:fun,:friendship,:mansearched, :womansearched, :publicmed, :profilepic
after_initialize :searchmynewconnected
before_validation :settingsuser
def zodiacsign
k=OrthodoxHoroscope.all.sort_by{|h|h.begin}.sort_by{|h|h.end}
k << k[0]
year=self.dateofbirth.year.to_i
l=k.select.with_index do |a,i|
if i==0
self.dateofbirth >= a.begin.change(year: (year - 1)) && self.dateofbirth <= a.end.change(year: (year))
elsif i==12
self.dateofbirth >= a.begin.change(year: (year)) && self.dateofbirth <= a.end.change(year: (year + 1))
else
self.dateofbirth >= a.begin.change(year: (year)) && self.dateofbirth <= a.end.change(year: (year))

end


end
l[0]
end
def hasADescription
y=self.description
y && y.length > 1
end
def hasNotADescription
y=self.description
!y || (y && y.strip.squish == 0)
end
def chinesezodiac
ChineseHoroscope.joins('left join chinese_horoscope_dates dates on dates.chinese_horoscope_id = chinese_horoscopes.id').select('chinese_horoscopes.*, dates.begin, dates.end').group('chinese_horoscopes.id, dates.begin, dates.end').having('dates.end >= ? and dates.begin <= ?', self.dateofbirth, self.dateofbirth)[0]
end
def datingserious?
relationships.where(name: "Serious").length > 0
end
def datingfun?
relationships.where(name: "Fun").length > 0
end
def friendship?
relationships.where(name: "Friendly").length > 0
end
def settingsuser
if !self.Gender && self.Password && self.Month && self.Year && self.Day
self.password = self.Password if self.Password.squish.strip.length > 0
self.dateofbirth = Date.new(self.Year.to_i, self.Month.to_i, self.Day.to_i)
self.errors.add(:dateofbirth, :invalid) if self.sonage < 18 || self.sonage > 99
end
end
def searchmynewconnected
self.range_1 ||= "18"
self.range_2 ||= "99"
self.myoffset = 0 if self.first == "true"
self.myoffset ||= 0
mylimit=30
self.myoffset = (self.myoffset.to_i + 1) if self.next == "true"
self.myoffset = (self.myoffset.to_i - 1) if self.previous == "true"
self.myoffset = 1 if self.myoffset.to_i < 1 

#f1="count(fun.id) = 1" if self.fun == "1"
#f2="count(friendly.id) = 1" if self.firiendship == "1"
#f3="count(serious.id) = 1" if self.serious == "1"
f1="count(rel.name = \"Fun\") = 1" if self.fun == "1"
f2="count(rel.name = \"Friendly\") = 1" if self.friendship == "1"
f3="count(rel.name = \"Serious\") = 1" if self.serious == "1"

rel=[f1, f2, f3].select{|h|h}
rel=rel.length > 0 ? rel.join(' and ').to_s : ""
p rel.to_s
self.searchnewconnected = User.select("users.*, count(photos.id) as countpublicmed, ceil((cast(count(users.id) OVER() as float) / 30.0))  as mynbpage, floor(cast((CURRENT_DATE - users.dateofbirth) as float) /365.0) as sonage, coalesce(users.malesearched, false) as malesearched2, coalesce(users.femalesearched, false) as femalesearched2").withage(self.range_1, self.range_2).searchamale(self.mansearched).searchafemale(self.womansearched).left_joins(:publicphotos).groupbyuser.withppic(self.profilepic).group("users.id").left_outer_joins(:relationships).isfun(self.fun).isserious(self.serious).isfriendship(self.friendship).withpublicmed(self.publicmed).nickname(self.chattername).selectsome(((self.myoffset.to_i - 1) * 30),self)

#.selectrelationships.having(rel).p


end
def myfunc
while self.myoffset.to_i > 1 && self.searchnewconnected[0].try(:mynbpage).to_i == 0 do
self.myoffset = (self.myoffset.to_i - 1) if self.previous == "true"
self.searchmynewconnected
end
end
def self.selectsome(x,me)
mylimit=30
#me.mynbpage=(all.to_a.length.to_f / mylimit.to_f).ceil

offset((x ? x.to_i : 0)).limit(mylimit)

end
def self.withage(min,max)
having(["floor(cast((CURRENT_DATE - users.dateofbirth) as float) /365.0) >= ? and floor(cast((CURRENT_DATE - users.dateofbirth) as float) /365.0) <= ? ", min, max])

end
def self.nickname(x)
if x && x.length > 0
having("lower(users.name) like ?", ("%"+x.to_s.downcase+"%"))
else
all
end
end
def self.isserious(x)
if x == "1"
#relationjointable.left_joins('left outer join relationships serious on serious.id = u.relationship_id and serious.name = \'Serious\'').having('count(serious.id) > 0')
select('count(distinct case when relationships.name = \'Serious\' then 1 else 0 end) as isserious').having('sum(distinct case when relationships.name = \'Serious\' then 1 else 0 end) = 1')

else
all
end
end
def self.isfun(x)
if x == "1"
#relationjointable.left_joins('left outer join relationships f on f.id = u.relationship_id and f.name = \'Serious\'').having('count(distinct f.id) > 0')
having('count(distinct case when relationships.name = \'Fun\' then 1 else 0 end) > 0').having('sum(distinct case when relationships.name = \'Fun\' then 1 else 0 end) = 1')

else
all
end
end
def self.isfriendship(x)
if x == "1"
#relationjointable.left_joins('left outer join relationships fr on fr.id = u.relationship_id and fr.name = \'Friendly\'').having('count(distinct fr.id) > 0')
having('count(distinct case when relationships.name = \'Friendly\' then 1 else 0 end) > 0').having('sum(distinct case when relationships.name = \'Friendly\' then 1 else 0 end) = 1')

else
all
end
end
def self.withpublicmed(x)
if x == "1"
having("count(photos.id) > 0")
else
all
end
end
def self.withppic(x)
if x == "1"
having("users.image is not null or length(users.image) > 1")
else
all
end
end
def self.searchamale(x)
having((x == "1" ? ("coalesce(users.malesearched, false) is true") : "coalesce(users.malesearched, false) is true or coalesce(users.malesearched, false) is false"))
end
def self.searchafemale(x)
having((x == "1" ? "coalesce(users.femalesearched, false) is true" : "coalesce(users.femalesearched, false) is true or coalesce(users.femalesearched, false) is false"))
end
def self.groupbyuser
group('users.id')
end
def self.selectrelationships
select("rel.name as relanem, count(rel.name = 'Friendly') as friendly, count(rel.name = 'Fun') as fun,count(rel.name = 'Serious') as serious").withrelationship
#select("count(friend.id else 0 end) as isfriendly, count(fun.id else 0 end) as isfun,count(serious.id else 0 end) as isserious").withrelationship
end
def self.withpublicphotos
left_joins(:publicphotos)
end
def self.relationjointable
left_joins('left outer join userrelationships u on u.user_id = users.id')
end
def self.withrelationship
#short
left_joins('left outer join userrelationships u on u.user_id = users.id').left_joins('left outer join relationships rel on rel.id = u.relationship_id')

#long
#relationjointable.left_joins('left outer join relationships fun on fun.id = u.relationship_id and fun.name = \'Fun\'').left_joins('left outer join relationships serious on serious.id = u.relationship_id and serious.name = \'Serious\'').left_joins('left outer join relationships friendly on friendly.id = u.relationship_id and friendly.name = \'Friendly\'')
#relationjointable.left_joins('left outer join userrelationships u on u.user_id = users.id').left_joins('left outer join relationships fun on fun.id = u.relationship_id and fun.name = \'Fun\'').left_joins('left outer join relationships serious on serious.id = u.relationship_id and serious.name = \'Serious\'')

end
def newinterlocutors
User.select(('count(distinct sentm.receiver_id) as mysender, users.name,users.id as userid,m.sender_id,m.sender_id,sender.name as sendername,(case when sender.gender = \'1\' then \'F\' else \'M\' end) as sendergender,count(case when sentm.sender_id = users.id then 1 else 0 end) as countanswer,floor(cast((CURRENT_DATE - sender.dateofbirth) as float) /365.0) as senderage,sender.femalesearched as senderfemalesearched,sender.malesearched as sendermalesearched,sender.online as senderonline')).joins("left join messages m on m.receiver_id = users.id").joins("left join messages sentm on sentm.sender_id = users.id or sentm.receiver_id = users.id").group('users.id,m.sender_id,m.receiver_id,m.sender_id,sendername,sendergender,senderage,senderfemalesearched,sendermalesearched,senderonline').joins("left join users sender on sender.id = m.sender_id ").having('m.receiver_id =  \''+self.id.to_s+'\' ').joins('left join messages as conv on (conv.sender_id = m.receiver_id and conv.receiver_id = m.sender_id) or (conv.sender_id = m.sender_id and conv.receiver_id = m.receiver_id)').having('count(distinct conv.sender_id = m.receiver_id and conv.receiver_id = m.sender_id) = 1')

# and count(case when sentm.sender_id != users.id then 1 else 0 end) = 0')
end
def nbnewinterlocutors
self.newinterlocutors.length
end
def currentconversations
User.select(('users.name,users.id as userid,m.sender_id,m.receiver_id,receiver.name as receivername,(case when receiver.gender = \'1\' then \'F\' else \'M\' end) as receivergender,floor(cast((CURRENT_DATE - receiver.dateofbirth) as float) /365.0) as receiverage,receiver.femalesearched as receiverfemalesearched,receiver.malesearched as receivermalesearched,receiver.online as receiveronline')).joins("left join messages m on m.sender_id = users.id ").joins("left join users receiver on receiver.id = m.receiver_id ").group('users.id,m.sender_id, m.receiver_id,receiver.id,receivername,receivergender,receiverage,receivermalesearched,receiverfemalesearched,receiveronline').having('m.sender_id = ? and m.receiver_id != ? ', self.id, self.id)
end
def self.connectedfirstpart
User.nbpageonline1
end
def self.connectedsecondpart
User.nbpageonline2
end
def allmessages
m=self.outmsgs+self.inmsgs
m.sort_by! {|a|a.created_at}
m
end 
def exchangedmessagesdeleteall
self.outmsgs.destroy_all && self.inmsgs.destroy_all
end
def exchangedmessagesalldeleted
self.outmsgs.length == 0 && self.inmsgs.length == 0
end
has_many :myfavoriteusers
has_many :favorites, through: :myfavoriteusers, source: :favorite, class_name: "User"
def myfavorites
User.joins("left join myfavoriteusers m on m.favorite_id = users.id").having('m.user_id = ?', self.id).group("users.id,m.user_id,m.favorite_id").select("users.*, m.user_id, m.favorite_id")
end

def myfollowers
User.joins("left join myfavoriteusers m on m.user_id = users.id").having('m.favorite_id = ?', self.id).group("users.id,m.user_id,m.favorite_id").select("users.*, m.user_id, m.favorite_id")
end
has_many :myblacklistedusers
has_many :blacklisted, through: :myblacklistedusers, source: :blacklisted, class_name: "User"

has_many :abuseusers
has_many :abuses, through: :abuseusers, source: :abuse, class_name: "User"

has_many :userinterests
has_many :interests, through: :userinterests
has_many :myprivatephotos
has_many :privatephotos, through: :myprivatephotos, source: :photo
has_many :mypublicphotos
has_many :publicphotos, through: :mypublicphotos, source: :photo
  attr_accessor :myoffset, :Interests
def abuse?(myid)
self.abuses.find_by(id: myid)
end
def cansendflashmessage(myid)
self.notabuse?(myid) && User.find(myid).notabuse?(self)
end
def canChat
self.online
end
def notabuse?(myid)
!self.abuses.find_by(id: myid)
end
def favorite?(myid)
self.favorites.include?(User.find(myid))
end
def blacklisted?(myid)
self.blacklisted.include?(User.find(myid))
end
attr_reader :interlocutorId
before_validation :myinterests
def myinterests
if self.Interests
list=self.Interests.values
myids=self.interest_ids
list.select{|x|x[".Id"] && x[".Interested"]=="false"}.each do |y|
self.interests.delete(Interest.find(y['.Id']))
end
list.select{|x|x[".Id"] && x[".Interested"]=="true" && !myids.include?(x['.Id'].to_i)}.each do |y|
self.interests << Interest.find(y['.Id'])
end
end
end 
def moveotheralbum(photo)
if photo.myprivatephotos.length > 0
self.privatephotos.delete(photo)

self.publicphotos << photo
elsif photo.mypublicphotos.length > 0
self.publicphotos.delete(photo)

self.privatephotos << photo
end
end
def changeprofilepic(photo)
write_attribute(:image, photo.url)
save
end
attr_accessor :Weight, :userpic
attr_accessor "Country", "Subdivision","Description","Weight", "Height"
attr_accessor :GenderSearchedWoman, :GenderSearchedMan
has_many :userrelationships
has_many :relationships, through: :userrelationships
attr_accessor "DatingSearchedFriendly", "DatingSearchedSerious", "GenderSearchedMan", "GenderSearchedWoman", :DatingSearchedFun
attr_accessor 'DontShowOnProfile'
def initializevalues
self.GenderSearchedWoman = self.femalesearched
self.GenderSearchedMan = self.malesearched
self.Description = self.description
self.Weight = self.weight
self.Height = self.height
self.Subdivision = self.subdivision

end
before_validation :setmyvalues
def setmyvalues
if self.userpic
File.open(Rails.root.join('app/assets', 'images', self.userpic.original_filename), 'wb') do |f|
  f.write(self.userpic.read)
end
self.image=self.userpic.original_filename
end
if self.GenderSearchedWoman
self.femalesearched = self.GenderSearchedWoman
end
if self.GenderSearchedMan
self.malesearched = self.GenderSearchedMan
end
if self.DontShowOnProfile && self.DontShowOnProfile == "false"
self.showinfo = true
elsif self.DontShowOnProfile && self.DontShowOnProfile == "true"
self.showinfo = false
end
if self.OptIn && self.OptIn == "true"
self.opt_in = true
elsif self.OptIn && self.OptIn == "false"
self.opt_in = false
end
Relationship.all.each do |rel|
m= self.send("DatingSearched#{rel.name}")
if m && !self.relationships.find_by_id(rel.id)
p m
begin
self.relationships << rel
rescue ActiveRecord::RecordInvalid
next
end
elsif !m 

self.userrelationships.where(relationship_id: rel.id).destroy_all

end

end
if self.Description
self.description=self.Description
end
if self.Country
self.country=self.Country
end
if self.Subdivision
self.subdivision=self.Subdivision
end
if self.Weight
self.weight=self.Weight
end
if self.Height
self.height=self.Height
end
end


  after_update_commit { UserBroadcastJob.perform_later(self) }
def interlocutorId
"TchatchePass"+self.id.to_s
end
def appear(offset)
self.myoffset = offset
self.update(online: true)
end
def disappear(offset)
self.myoffset = offset
self.update(online: false)
end
def self.nbpageonline
where(online: true).length.to_i / 30
end
def self.nbpageonline1
j=nbpageonline.to_s.split(',')
j.pop
j.join('')
end
def self.nbpageonline2
j=nbpageonline.to_s.split(',')
j.last
end
def self.nbonline
where(online: true).count
end
def sonage
#floor(cast((CURRENT_DATE - sender.dateofbirth) as float) /365.0) as sonage
j=Date.today - self.dateofbirth
(j.to_f / 365.to_f).floor.to_i

end
def self.useronline(userid) #x data-bind="text:page"
k=select("users.*, (case when users.id = '#{userid}' then 1 else 2 end) as sortn,(case when users.online then 1 when users.online is null then 3 else 2 end) as sortm, users.id").group("users.id").order(sortm: :asc, sortn: :asc)
k.offset((0)).limit(30)
end
  attr_accessor :Gender, :MaleSearched,:FemaleSearched,:Month,:Day,:Year,:Email,:PhoneNumber,:Latitude,:Longitude,:Name,:Password,:fake_country,:Country,:OptIn,:termsCgu,:termsPrivacy
    after_initialize do
    dixhuit=Date.today - 18.years
    self.Day = dixhuit.day
    self.Month = dixhuit.month
    self.Year = dixhuit.year
    end

def after_database_authentication
        # here's the custom code
    end

before_validation :validparams
def validparams
if self.Gender
self.gender = self.Gender
self.email = self.Email
self.password = self.Password
self.femalesearched = self.FemaleSearched == "1"
self.malesearched = self.MaleSearched == "2"
self.dateofbirth = Date.new(self.Year, self.Month, self.Day)
self.country = self.Country
self.opt_in=self.OptIn
self.phonenumber=self.PhoneNumber
self.name=self.Name

end

end
def iswoman?
gender == "1"
end
def isman?
gender == "0"
end
end
