require 'pry'


class Hotel < ActiveRecord::Base
    has_many :reservations 
    has_many :users, through: :reservations 

#USBAT see all accomodations 
#exists by default 

#USBAT see all accomodations by name 
    def self.name_search(hotel_name) 
        Hotel.all.select do |h_i|
            h_i.name == hotel_name
        end 
    end 

    def self.all_neighborhoods
        neighborhoods = []
        Hotel.all.select {|hotel| neighborhoods << hotel.neighborhood}
        neighborhoods.uniq.compact
    end 

#USBAT see all accomodations by location 
#edit to return a list of neighorhoods, edit for CLI appearance 
    def self.location_search(neighborhood) 
        Hotel.all.select do |n_i|
            n_i.neighborhood == neighborhood
        end     
    end 

#USBAT see all accomodations by person amount
    def self.capacity_search(number)
        if number == 1
        input = "#{number}"+" guest"
        else 
            input = "#{number}"+" guests"
        end 
        Hotel.all.select do |n_i|
            n_i.guest_amount == input 
        end 
    end 

#USBAT see all accomodations by price (user inputs top budget per night) 
    def self.budget_search(min, max) #return objects in that range 
         Hotel.all.select do |h_i|
         h_i.price < max && h_i.price > min 
     end 
    end 


end









