class Userrelationship < ApplicationRecord
belongs_to :user
belongs_to :relationship
validates_uniqueness_of :user_id, scope: :relationship_id
end
