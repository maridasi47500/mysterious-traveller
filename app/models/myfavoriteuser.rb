class Myfavoriteuser < ApplicationRecord
validates_uniqueness_of :favorite_id, scope: :user_id
belongs_to :user
belongs_to :favorite, class_name: "User"
end