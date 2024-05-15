class Abuseuser < ApplicationRecord
validates_uniqueness_of :abuse_id, scope: :user_id
belongs_to :abuse, class_name: "User"
belongs_to :user
end
