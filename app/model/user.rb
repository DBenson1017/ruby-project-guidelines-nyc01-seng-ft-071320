class User < ActiveRecord::Base
    has_many :reservations 
    has_many :hotels, through: :reservations 

end


