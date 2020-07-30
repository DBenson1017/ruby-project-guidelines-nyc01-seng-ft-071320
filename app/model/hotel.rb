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


    # def self.neighborhood_cli
    #     # puts "Please enter the neighborhood you are interested in from the list above."
    #     # u_input = STDIN.gets.chomp.strip 
    #     puts Hotel.location_search
    #     puts "Press any key to return to the accomodations menu."
    #     any_key = STDIN.gets
    #     Hotel.accomodations_search 
    # end 

 
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
def self.guest_amount_cli 
        puts "Please enter the amount of guests you would like to seach for."
        input = STDIN.gets.chomp.strip 
        Hotel.capacity_search(input)
        puts "Press any key to return to the accomodations menu."
        any_key = STDIN.gets
        Hotel.accomodations_search 
        end 

def self.capacity_search(number) 
    if number == '1'
    input = "#{number}"+" guest"
    else 
        input = "#{number}"+" guests"
    end 
    results = []
    results = Hotel.all.select do |h|
       if h.guest_amount == input  
        puts "ID: #{h.id}\n
        Name: #{h.name}\n
        Price: #{h.price}\n
        Beds: #{h.beds}\n
        Guest Count: #{h.guest_amount}\n
        Neighborhood: #{h.neighborhood}"
       end 
       if results.count == 0 
        puts "We're sorry, there are no accomodations that match that criteria."
        puts 'press 1 to start a new search'
       end 
        input = STDIN.gets.chomp.strip 
        if input == '1'
            Hotel.guest_amount_cli 
        end 
    end 
end 

#user option 5 - by price 
def self.price_cli 
    puts "Here you can search for accomodations within your budget."
    puts ''
    puts "What is the least amount you want to pay per night (ex. 100)?"
    min = STDIN.gets.chomp.strip 
    puts ''
    puts "What is the most you want to pay per night (ex. 200)?"
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
    results = Hotel.all.select do |h|
    if h.price < max && h.price > min 
        puts "ID: #{h.id}
        Name: #{h.name}
        Price: #{h.price}
        Beds: #{h.beds}
        Guest Count: #{h.guest_amount}
        Neighborhood: #{h.neighborhood}\n"
       end 
    end 
    if results.count == 0 
        puts "We're sorry, there are no accomodations that match that criteria."
        puts 'press 1 to start a new search'
       end 
        input = STDIN.gets.chomp.strip 
        if input == '1'
            Hotel.price_cli 
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
end 









