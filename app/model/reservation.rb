class Reservation < ActiveRecord::Base
    belongs_to :hotels
    belongs_to :user
end
