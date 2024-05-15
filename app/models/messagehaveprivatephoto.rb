class Messagehaveprivatephoto < ApplicationRecord
belongs_to :photo
belongs_to :message
validates_uniqueness_of :message_id, scope: :photo_id
end