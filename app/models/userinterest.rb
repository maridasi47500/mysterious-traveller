class Userinterest < ApplicationRecord
belongs_to :interest
belongs_to :user
validates_uniqueness_of :user_id, scope: :interest_id
end