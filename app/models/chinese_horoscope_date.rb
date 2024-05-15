class ChineseHoroscopeDate < ApplicationRecord
belongs_to :chinese_horoscope
validates_uniqueness_of :begin, scope: :end
validates_presence_of :begin
validates_presence_of :end
end
