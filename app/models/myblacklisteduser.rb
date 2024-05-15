class Myblacklisteduser < ApplicationRecord
validates_uniqueness_of :blacklisted_id, scope: :user_id
belongs_to :user
belongs_to :blacklisted, class_name: "User"
end