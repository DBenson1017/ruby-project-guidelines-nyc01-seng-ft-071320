require 'pry'


class Hotel < ActiveRecord::Base
    has_many :reservations 
    has_many :users, through: :reservations 




end



    ################CLI##############
    #When user wants to see available accomodations 
    # def accomodations_search 
    #     puts 'Welcome! Here you can search our available accomodations.'
    #     puts ' '
    #     puts 'To see all accomodations, press 1'
    #     puts " "
    #     puts 'To search accomodations by neighborhood, press 2'
    #     puts 'To search accomodations by beds, press 3'
    #     puts 'To search accomodations by guest capacity, press 4'
    #     puts 'To search accomodations by price, press 5'
    #     puts 'Press 6 to return to the main menu'
    #     u_input = gets.chomp.strip 
    #     case u_input 
    #     when '1'
    #         Hotel.see_all_hotels 
    #     when '2'
    #         Hotel.neighborhood_cli
    #     when '3'
    #     when '4'
    #     when '5'
    #     when '6'

#neighborhood searches             
# def self.neighorhood_cli
#     puts "To see a list of available neighborhoods, press 1"
#     puts "To search by a specific neighborhood, press 2"
#     puts 'Press 3 to return to the main menu.'
#     u_input = gets.chomp.strip 
#     case u_input
#     when '1'
#         Hotel.all_neighborhoods
#         #how do they go back?
#     when '2'
#         puts "Please enter the neighboohood you are interested in."
#         hood = gets.chomp.strip 
#         Hotel.location_search(hood)
#     when '3'
#         #return to main menu 
#     end 
# end 

# #bed searches 
# def self.bed_search(input) 
#     num = input.to_i
#     Hotel.all.select do |h_i|
#       if h_i.beds == num
#         h_i
#       end 
#     end  
#     binding.pry    
# end 




#     ########by neighborhood 

#     def self.all_neighborhoods
#         neighborhoods = []
#         Hotel.all.select {|hotel| neighborhoods << hotel.neighborhood}
#         neighborhoods.uniq.compact
#     end 

# #USBAT see all accomodations by location 
# #edit to return a list of neighorhoods, edit for CLI appearance 
#     def self.location_search(neighborhood) 
#         Hotel.all.select do |n_i|
#             n_i.neighborhood == neighborhood
#         end     
#     end 


#     def see_all_hotels
#         Hotels.all
#     end 



# #USBAT see all accomodations by name 
#     def self.name_search(hotel_name) 
#         Hotel.all.select do |h_i|
#             h_i.name == hotel_name
#         end 
#     end 

#     def self.all_neighborhoods
#         neighborhoods = []
#         Hotel.all.select {|hotel| neighborhoods << hotel.neighborhood}
#         neighborhoods.uniq.compact
#     end 

# #USBAT see all accomodations by location 
# #edit to return a list of neighorhoods, edit for CLI appearance 
#     def self.location_search(neighborhood) 
#         Hotel.all.select do |n_i|
#             n_i.neighborhood == neighborhood
#         end     
#     end 

# #USBAT see all accomodations by person amount
#     def self.capacity_search(number)
#         if number == 1
#         input = "#{number}"+" guest"
#         else 
#             input = "#{number}"+" guests"
#         end 
#         Hotel.all.select do |n_i|
#             n_i.guest_amount == input 
#         end 
#     end 

# #USBAT see all accomodations by price (user inputs top budget per night) 
#     def self.budget_search(min, max) #return objects in that range 
#          Hotel.all.select do |h_i|
#          h_i.price < max && h_i.price > min 
#      end 
#     end 

#  end









