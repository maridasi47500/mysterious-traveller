class Photo < ApplicationRecord
validates_uniqueness_of :url
has_many :myprivatephotos
has_many :privateusers, through: :myprivatephotos, source: :photo
has_many :mypublicphotos
has_many :publicusers, through: :mypublicphotos, source: :photo

has_many :messagehaveprivatephotos
has_many :messages, :through => :messagehaveprivatephotos, source: :message

attr_accessor :userpic
before_validation :setmyvalues
def setmyvalues
if self.userpic
File.open(Rails.root.join('app/assets', 'images', self.userpic.original_filename), 'wb') do |f|
  f.write(self.userpic.read)
end
self.url=self.userpic.original_filename
end
end
def destroyphoto
path_to_file=Rails.root.join('app/assets/images',self.url)
 File.delete(path_to_file) if File.exist?(path_to_file)
true
rescue => e
p e.message
end

end
