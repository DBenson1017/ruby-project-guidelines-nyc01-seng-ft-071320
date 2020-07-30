require 'pry'


class Hotel < ActiveRecord::Base
    has_many :reservations 
    has_many :users, through: :reservations 
def self.all_accomidations
  Hotel.all.each do |r|
  puts "Id: #{r.id}\nName: #{r.name}\nPrice: #{r.price}\nBeds: #{r.beds}\nGuest Count: #{r.guest_amount}\nNeighborhood: #{r.neighborhood}\n\n"
  end
end
#user option 1 - see all accomodations 
#status: needs exit CLI path 
def self.all_hotels
    Hotel.all.each do |h|
        puts "ID: #{h.id}\n
        Name: #{h.name}\n
        Price: #{h.price}\n
        Beds: #{h.beds}\n
        Guest Count: #{h.guest_amount}\n
        Neighborhood: #{h.neighborhood}"
    end 
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
end 

#searches accomodations by neighborhood name 
def self.location_search(u_input)
    Hotel.all.select do |h|
       if h.neighborhood == u_input
        puts "ID: #{h.id}\n
        Name: #{h.name}\n
        Price: #{h.price}\n
        Beds: #{h.beds}\n
        Guest Count: #{h.guest_amount}\n
        Neighborhood: #{h.neighborhood}"
       end 
    end 
end 

#user option 3 - by beds
#status: needs exit CLI path  
# any_key = STDIN.gets
# Hotel.accomodations_search 

def self.bed_cli 
    puts "Please enter the amount of beds you would like to seach for."
    user_input = STDIN.gets.chomp.strip 
    Hotel.bed_search(user_input)
    #exit path?
end 

def self.bed_search(input) 
    Hotel.all.select do |h|
      if h.beds == input 
        puts "ID: #{h.id}\n
        Name: #{h.name}\n
        Price: #{h.price}\n
        Beds: #{h.beds}\n
        Guest Count: #{h.guest_amount}\n
        Neighborhood: #{h.neighborhood}"
       end 
    end  
    
end 

#user option 4 - by guest capacity 
#status: needs exit CLI path  

# any_key = STDIN.gets
# Hotel.accomodations_search 
def self.guest_amount_cli #works 
        puts "Please enter the amount of guests you would like to seach for."
        input = STDIN.gets.chomp.strip 
        Hotel.capacity_search(input)
        end 

def self.capacity_search(number) 
    if number == '1'
    input = "#{number}"+" guest"
    else 
        input = "#{number}"+" guests"
    end 
    Hotel.all.select do |h|
       if h.guest_amount == input  
        puts "ID: #{h.id}\n
        Name: #{h.name}\n
        Price: #{h.price}\n
        Beds: #{h.beds}\n
        Guest Count: #{h.guest_amount}\n
        Neighborhood: #{h.neighborhood}"
       end 
    end 
end 

#user option 5 - by price 
#status: exit and new search CLI path 
# any_key = STDIN.gets
# Hotel.accomodations_search 

def self.price_cli #works 
    puts "Here you can search for accomodations withing your budget."
    puts ''
    puts "What is the least amount you want to pay per night?"
    min = STDIN.gets.chomp.strip 
    puts ''
    puts "What is the most you want to pay per night?"
    max = STDIN.gets.chomp.strip 
    puts Hotel.budget_search(min, max)
end 

def self.budget_search(min, max) 
    min = min.to_i
    max = max.to_i
    Hotel.all.select do |h|
    if h.price < max && h.price > min 
        puts "ID: #{h.id}\n
        Name: #{h.name}\n
        Price: #{h.price}\n
        Beds: #{h.beds}\n
        Guest Count: #{h.guest_amount}\n
        Neighborhood: #{h.neighborhood}"
       end 
    end 
end 

# def reservations(h_id) #not tested 
#     Reservation.all.select do |r|
#         r.hotel.id == h_id
#     end 




   #accomodations main menu 
   def Hotel.accomodations_search 
    puts 'Welcome! Here you can search our available accomodations.'
    puts ' '
    puts 'To see all accomodations, press 1'
    puts " "
    puts 'To search accomodations by neighborhood, press 2'
    puts 'To search accomodations by beds, press 3'
    puts 'To search accomodations by guest capacity, press 4'
    puts 'To search accomodations by price, press 5'
    puts 'Press 6 to return to the main menu'
    u_input = STDIN.gets.chomp.strip 
    case u_input 
    when '1'
        Hotel.all_hotels 
        #exit path and back option 
    when '2'
        Hotel.neighborhood_cli
        # exit path and back option 
    when '3'
        Hotel.bed_cli 
    when '4'
        Hotel.guest_amount_cli 
    when '5'
        Hotel.price_cli
    # when '6'
        #path to main menu    
end 


end
end 









