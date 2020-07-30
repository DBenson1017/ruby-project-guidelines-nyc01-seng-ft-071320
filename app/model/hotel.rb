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
<<<<<<< HEAD


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
=======
    puts "Press any key to return to the main menu."
    any_key = STDIN.gets
    Hotel.accomodations_search 
end 

#user option 2 - neighborhood searches    
#status: needs exit CLI path  
# any_key = STDIN.gets
# Hotel.accomodations_search        

#puts the array of available neighborhoods 
def self.neighborhood_cli
    puts Hotel.all_neighborhoods 
    puts "Please enter the neighborhood you are interested in from the list above."
    u_input = STDIN.gets.chomp.strip 
    puts Hotel.location_search(u_input) 
    #exit path?
end 

#shows available neighbnorhoods 
def self.all_neighborhoods 
    neighborhoods = []
    Hotel.all.select {|hotel| neighborhoods << hotel.neighborhood}
    puts neighborhoods.uniq.compact 
    neighborhoods.uniq.compact
end 
>>>>>>> 0a96660e9988e3818a859f50cffd040486d586ab

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

    

<<<<<<< HEAD

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
=======
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
>>>>>>> 0a96660e9988e3818a859f50cffd040486d586ab
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
<<<<<<< HEAD
   def Hotel.accomodations_search 
    puts 'ACCOMODATIONS SEARCH'
    puts '____________________ '
    puts 'To see ALL ACCOMODATIONS, press 1'
=======
   def self.accomodations_search 
    puts 'Welcome! Here you can search our available accomodations.'
    puts ' '
    puts 'To see all accomodations, press 1'
>>>>>>> 0a96660e9988e3818a859f50cffd040486d586ab
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









