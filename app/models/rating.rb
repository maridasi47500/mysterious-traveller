class Rating < ApplicationRecord
validates_uniqueness_of :user_id, scope: :notinguser_id

before_validation :myrating
def myrating
if self.user_id == self.notinguser_id
self.errors.add(:base, "Unable to note one's own profile")

end
end

end