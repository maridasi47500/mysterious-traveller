require 'json'
class Message < ApplicationRecord
belongs_to :sender, class_name: "User"
belongs_to :receiver, class_name: "User"
def mycontent1
k=self.read_attribute(:content) || ""
Emoji.all.each do |h|
k.gsub!(h.code, (h.code.gsub("\\","&#x")+";"))
end
k
end
attr_accessor :mypic
has_many :messagehaveprivatephotos
has_many :privatephotos, :through => :messagehaveprivatephotos, source: :photo
after_save :photocontent
def photocontent
if self.mypic
self.privatephotos << Photo.find(self.mypic)
end
end
attr_accessor :mycontent
before_validation :validmess
def self.notread
where("messages.read" => [false,nil]).joins('left join users u on u.id = messages.sender_id').group("u.id, messages.id").select("DISTINCT ON (messages.id) messages.*,messages.sender_id,messages.id as msgid, u.name as username, u.gender as usergender, u.id as uid")
end
def validmess
if self.mycontent && self.mycontent.length
k=self.mycontent
self.sender_id=k[1]
self.receiver_id=k[0]
self.content=k[2]
end
end
  #after_create_commit { MessageBroadcastJob.perform_later self }
def self.findby(me,her)
where(['(sender_id = ? and receiver_id = ?) or (sender_id = ? and receiver_id = ?)',me,her,her,me])
end

end
