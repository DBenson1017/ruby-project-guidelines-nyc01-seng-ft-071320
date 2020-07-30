require 'pry'


class Hotel < ActiveRecord::Base
    has_many :reservations 
    has_many :users, through: :reservations 

    #user option 1 - see all accomodations 
    def self.all_hotels
        Hotel.all.each do |h|
            puts "ID: #{h.id}
            Name: #{h.name}
            Price: #{h.price}
            Beds: #{h.beds}
            Guest Count: #{h.guest_amount}
            Neighborhood: #{h.neighborhood}\n"
        end 
        puts "Press any key to return to the accomodations menu."
        any_key = STDIN.gets
        Hotel.accomodations_search  
    end 
 
    def self.all_neighborhoods 
        neighborhoods = []
        Hotel.all.select {|hotel| neighborhoods << hotel.neighborhood}
        puts neighborhoods.uniq.compact 
        neighborhoods.uniq.compact
    end 

    #user option 2 - neighborhood searches 
    #searches accomodations by neighborhood name 
    #BUG - when u_input is not included, returns the neighborhood list again 
    def self.location_search
        Hotel.all_neighborhoods 
        puts "Please enter the neighborhood you are interested in from the list above."
        u_input = STDIN.gets.chomp.strip 
    if Hotel.all_neighborhoods.include?(u_input)
            Hotel.all.select do |h|
            if h.neighborhood == u_input
            puts "ID: #{h.id}
            Name: #{h.name}
            Price: #{h.price}
            Beds: #{h.beds}
            Guest Count: #{h.guest_amount}
            Neighborhood: #{h.neighborhood}\n"
                end 
            end
        else 
            puts ''
            puts "Sorry, we don't have any neighborhoods by that name!"
            Hotel.accomodations_search 
            return 
        end 
        puts "Press any key to return to the accomodations menu."
        any_key = STDIN.gets
        Hotel.accomodations_search 
    end 

    #user option 3 - by beds

    def self.all_beds
        beds = []
        Hotel.all.select {|hotel| beds << hotel.beds}
        # puts beds.uniq.compact 
        beds.uniq.compact
        # binding.pry 
    end 

    def self.bed_cli 
        puts "Please enter the amount of beds you would like to seach for (ex. 2)."
        user_input = STDIN.gets.chomp.strip 
        if Hotel.all_beds.include?(user_input)
            results = Hotel.all.where(beds: user_input) 
            results.each do |h|
                puts "ID: #{h.id}
                    Name: #{h.name}
                    Price: #{h.price}
                    Beds: #{h.beds}
                    Guest Count: #{h.guest_amount}
                    Neighborhood: #{h.neighborhood}\n"
            end 
            Hotel.book_accomodation_by_bed 
        else 
            puts "We're sorry, we don't have any accomodations with that amount of beds."
            Hotel.bed_cli 
        end 
    end 

    def Hotel.book_accomodation_by_bed 
        puts 
        'If you would like to make a reservation for any of these accomodations, enter (1)
        If you would like to make another search for Bed Amount enter (2)
        For the Accomodation Menu enter (3)'
        new_choice = STDIN.gets.chomp.strip
        case new_choice
        when '1'
            Reservation.create_new
        when '2'
            Hotel.bed_cli
        when '3'
            Hotel.accomodations_search
        else 
            puts 'Invalid'
            Hotel.book_accomodation_by_bed 
        end 
    end 

    

#user option 4 - by guest capacity 
#status: needs exit CLI path  
    def self.all_guest_amounts
        all_guest_amts_array = []
        Hotel.all.each {|h| all_guest_amts_array << h.guest_amount}
        all_guest_amts_array
    end


# Hotel.accomodations_search 
    def self.guest_amount_cli 
        puts "Please Enter the Guest Amount formated: '__ guest(s)'"
        input = STDIN.gets.chomp.strip 
        if Hotel.all_guest_amounts.include?(input)
            result = Hotel.all.where(guest_amount: input)
            result.each do |h|
                puts "ID: #{h.id}
                Name: #{h.name}
                Price: #{h.price}
                Beds: #{h.beds}
                Guest Count: #{h.guest_amount}
                Neighborhood: #{h.neighborhood}\n"
            end
            Hotel.book_accomidation_by_guest_amt 
        else
            puts "\nWere sorry. We don't have an accomidations avaliable for #{input}.\n"
            Hotel.accomodations_search
        end
    end 

    def self.book_accomidation_by_guest_amt
        puts "\nIf you would like to make a Reservation for any of these Accomidations (1)\nIf you would like to make another search by Guest Amount (2)\nAccomidations Menu (3)\n"
        new_choice = gets.chomp.strip
        case new_choice
        when "1"
            Reservation.create_new
        when "2"
            Hotel.guest_amount_cli
        when "3"
            Hotel.accomodations_search
        else
            puts "Invalid input. Please choose one of the options listed."
            Hotel.book_accomidation_by_guest_amt
        end
    end


#user option 5 - by price 
def self.price_cli 
    puts "\n\nSearch Accomodations by price range.\n"
    puts "What is your Minimum Amount:\n"
    min = STDIN.gets.chomp.strip 
    puts "What is the your Maximum:\n"
    max = STDIN.gets.chomp.strip 
    puts Hotel.budget_search(min, max)
    puts "Press any key to return to the accomodations menu."
    any_key = STDIN.gets
    Hotel.accomodations_search 
end 

    def self.budget_search(min, max) 
        min = min.to_i
        max = max.to_i
        results = []
        Hotel.all.each do |h|
            if h.price < max && h.price > min  
                results << h
            end
        end 
        if results.count != 0
            results.each do |h|       
                puts "ID: #{h.id}
                    Name: #{h.name}
                    Price: #{h.price}
                    Beds: #{h.beds}
                    Guest Count: #{h.guest_amount}
                    Neighborhood: #{h.neighborhood}\n"
            end
            Hotel.book_accomidation_by_price_range
        else    
            puts "Sorry there are no Accomodations that match your Price Range.\n"
            Hotel.price_cli
        end
    end 

    def self.book_accomidation_by_price_range
        puts "\nIf you would like to make a Reservation for any of these Accomidations (1)\nIf you would like to make another search by Price Range (2)\nAccomidations Menu (3)\n"
        new_choice = gets.chomp.strip
        case new_choice
        when "1"
            Reservation.create_new
        when "2"
            Hotel.price_cli
        when "3"
            Hotel.accomodations_search
        else
            puts "Invalid input. Please choose one of the options listed."
            Hotel.book_accomidation_by_guest_amt
        end
    end



   #accomodations main menu 
   def Hotel.accomodations_search 
    puts 'ACCOMODATIONS SEARCH'
    puts '____________________ '
    puts 'To see ALL ACCOMODATIONS, press 1'
    puts " "
    puts 'To search by:' 
    puts ''
    puts 'NEIGHBORHOOD,   press 2'
    puts 'NUMBER OF BEDS, press 3'
    puts 'GUEST CAPACITY, press 4'
    puts 'PRICE,          press 5'
    puts ' '
    puts 'Press 6 to return to the main menu'
    u_input = gets.chomp.strip 
    case u_input 
    when '1'
        Hotel.all_hotels 
    when '2'
        Hotel.location_search
    when '3'
        Hotel.bed_cli 
    when '4'
        Hotel.guest_amount_cli 
    when '5'
        Hotel.price_cli
    when '6'
        User.main_menu    
end 
end

    def self.all_accomidations
        Hotel.all.each do |r|
        puts "Id: #{r.id}\nName: #{r.name}\nPrice: #{r.price}\nBeds: #{r.beds}\nGuest Count: #{r.guest_amount}\nNeighborhood: #{r.neighborhood}\n\n"
        end
    end







end 









