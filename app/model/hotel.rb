
class Hotel < ActiveRecord::Base
    has_many :reservations 
    has_many :users, through: :reservations 


    def self.all_accomidations
        Hotel.all.each do |r|
            puts "Id: #{r.id}\nName: #{r.name}\nPrice: #{r.price}\nBeds: #{r.beds}\nGuest Count: #{r.guest_amount}\nNeighborhood: #{r.neighborhood}\n\n"
          end

    end



end

