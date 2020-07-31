
class Hotel < ActiveRecord::Base
    has_many :reservations 
    has_many :users, through: :reservations 
    
    def self.last_20
        Hotel.last(20)
    end


    def self.all_hotels
        Hotel.last_20.each do |h|
            puts "ID: #{h.id}
            Name: #{h.name}
            Price: #{h.price}
            Beds: #{h.beds}
            Guest Count: #{h.guest_amount}
            Neighborhood: #{h.neighborhood}
            City: #{h.city}\n"
        end 
        Hotel.book_accomodation_from_list 
    end 
    def Hotel.book_accomodation_from_list 
        puts "\nIf you would like to make a Reservation for any of these Accommodations (1)\nFor the Accommodations Menu (2)"
        new_choice = STDIN.gets.chomp.strip
        case new_choice
        when '1'
            Reservation.create_new
        when '2'
            Hotel.accomodations_search
        else 
            puts 'Invalid'
            Hotel.book_accomodation_by_bed 
        end 
    end
 
    def self.all_neighborhoods 
        neighborhoods = []
        Hotel.last_20.select {|hotel| neighborhoods << hotel.neighborhood}
        neighborhoods.uniq.compact
    end 

    def self.location_search
        unless Hotel.all_neighborhoods == []
            puts "\nWe have Accommodations in the following Neighborhoods:\n\n"
            puts Hotel.all_neighborhoods 
            puts "\nTo see Accommodations listed by Neighborhood, Enter the name of the Neighborhood:\n"
            u_input = STDIN.gets.chomp.strip 
            if Hotel.all_neighborhoods.include?(u_input) 
            results = Hotel.last_20.select {|h| h.neighborhood == u_input}
                results.each do |h|
                    puts "ID: #{h.id}
                        Name: #{h.name}
                        Price: #{h.price}
                        Beds: #{h.beds}
                        Guest Count: #{h.guest_amount}
                        Neighborhood: #{h.neighborhood}
                        City: #{h.city}\n"
                    end 
                Hotel.book_accomodation_by_neighborhood
            else 
            puts "\nSorry, we don't have any Neighborhoods named #{u_input}!"
            Hotel.accomodations_search 
            end 
        else
            puts "\n\nWe're sorry. None of our listings for the city you have choosen are labled with 'Neighborhood'.\nPlease search by another attribute.\n\n"
            Hotel.accomodations_search
        end
    end 

    def self.book_accomodation_by_neighborhood
        puts "\nIf you would like to make a Reservation for any of these Accommodations (1)\nIf you would like to make another search by Neighborhood (2)\nAccommodations Menu (3)"
        new_choice = STDIN.gets.chomp.strip
        case new_choice
        when '1'
            Reservation.create_new
        when '2'
            Hotel.location_search
        when '3'
            Hotel.accomodations_search
        else 
            puts "\nInvalid Entry, please select either (1) (2) (3)"
            Hotel.book_accomodation_by_neighborhood
        end 
    end 


    def self.all_beds
        beds = []
        Hotel.last_20.select {|hotel| beds << hotel.beds}
        beds.uniq.compact
    end 

    def self.bed_cli 
        puts "\nPlease Enter the number of Bed(s) you would like to seach by"
        user_input = STDIN.gets.chomp.strip 
        if Hotel.all_beds.include?(user_input)
            results = Hotel.last_20.select {|h| h.beds == user_input}
            results.each do |h|
                puts "ID: #{h.id}
                    Name: #{h.name}
                    Price: #{h.price}
                    Beds: #{h.beds}
                    Guest Count: #{h.guest_amount}
                    Neighborhood: #{h.neighborhood}
                    City: #{h.city}\n"
            end 
            Hotel.book_accomodation_by_bed 
        else 
            puts "We're sorry, we don't have any Accommodations with #{user_input} of beds."
            Hotel.bed_cli 
        end 
    end 

    def Hotel.book_accomodation_by_bed 
        puts "\nIf you would like to make a Reservation for any of these Accommodations (1)\nIf you would like to make another search by Bed Amount (2)\nFor the Accommodations Menu (3)"
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


    def self.all_guest_amounts
        all_guest_amts_array = []
        Hotel.last_20.each {|h| all_guest_amts_array << h.guest_amount}
        all_guest_amts_array
    end

    def self.guest_amount_cli 
        puts "Please Enter the Guest Amount formated: '__ guest(s)'"
        input = STDIN.gets.chomp.strip 
        if Hotel.all_guest_amounts.include?(input)
            result = Hotel.last_20.select {|h| h.guest_amount == input}
            result.each do |h|
                puts "ID: #{h.id}
                Name: #{h.name}
                Price: #{h.price}
                Beds: #{h.beds}
                Guest Count: #{h.guest_amount}
                Neighborhood: #{h.neighborhood}
                City: #{h.city}\n"
            end
            Hotel.book_accomidation_by_guest_amt 
        else
            puts "\nWere sorry. We don't have an Accommodations avaliable for #{input}.\n"
            puts "\nTo search by Guest Amount (1)\nTo return to Accommodations Menu (2)\n"
            u_choice = gets.chomp.strip
            u_choice == "1" ? Hotel.guest_amount_cli : Hotel.accomodations_search
            Hotel.guest_amount_cli
        end
    end 

    def self.book_accomidation_by_guest_amt
        puts "\nIf you would like to make a Reservation for any of these Accommodations (1)\nIf you would like to make another search by Guest Amount (2)\nAccommodations Menu (3)\n"
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


    def self.price_cli 
        puts "\n\nSearch Accommodations by price range\n"
        puts "What is your Minimum Amount:\n"
        min = gets.chomp.strip 
        puts "What is the your Maximum Amount:\n"
        max = gets.chomp.strip 
        puts Hotel.budget_search(min, max)
        puts "\nPress any key to return to the Accommodations menu."
        any_key = gets
        Hotel.accomodations_search 
    end 

    def self.budget_search(min, max) 
        results = []
        Hotel.last_20.each do |h|
            results << h if h.price <= max.to_i && h.price >= min.to_i  
        end 
        if results.count != 0
            results.each do |h|       
                puts "ID: #{h.id}
                    Name: #{h.name}
                    Price: #{h.price}
                    Beds: #{h.beds}
                    Guest Count: #{h.guest_amount}
                    Neighborhood: #{h.neighborhood}
                    City: #{h.city}\n"
            end
            Hotel.book_accomidation_by_price_range
        else    
            puts "Sorry there are no Accommodations that match your Price Range.\n"
            Hotel.price_cli
        end
    end 

    def self.book_accomidation_by_price_range
        puts "\nIf you would like to make a Reservation for any of these Accommodations (1)\nIf you would like to make another search by Price Range (2)\nAccommodations Menu (3)\n"
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
        puts "\n--ACCOMMODATIONS--\n\n"
        puts "\nLIST ALL ACCOMMODATIONS         (1)\n\n"
        puts "To search by:\n" 
        puts "NEIGHBORHOOD                    (2)"
        puts "NUMBER OF BEDS                  (3)"
        puts "GUEST CAPACITY                  (4)"
        puts "PRICE RANGE                     (5)\n\n"
        puts "MAIN MENU (6)  LOG OFF and Exit (7)"
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
        when "7"
            Cli.exit
        end  
    end 



end 









