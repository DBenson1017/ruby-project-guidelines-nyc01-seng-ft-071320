require 'pry'
Hotel.delete_all
User.delete_all
Reservation.delete_all


response = Unirest.get "https://airbnb-com.p.rapidapi.com/listings/nearby/40.750134/-73.997009",
  headers:{
    "X-RapidAPI-Host" => "airbnb-com.p.rapidapi.com",
    "X-RapidAPI-Key" => ENV['airbnb_key']
  }
data = response.body
# binding.pry
  
#######################################

####### SEEDING THE HOTELS TABLE ######
data["listings"].each do |listing|
    Hotel.create(name: listing["listing"]["name"], price: listing['pricing_quote']['rate']['amount'], beds: listing["listing"]["beds"], guest_amount: listing["listing"]["guest_label"], neighborhood: listing["listing"]["localized_neighborhood"])
end

##################SEED FOR USERS#####################
User.create(first_name:'Brian', last_name:'Lego', email: "1234", password: "1234")
User.create(first_name:'Devin', last_name:'Benson', email: "db@email.com", password: "4567")
User.create(first_name:'Juju', last_name:'Bee', email: "runnerup@email.com", password: "8910")
User.create(first_name:'Alyssa', last_name:'Edwards', email: "dancingelite@email.com", password: "1011")

###### SEEDS FOR RESERVATIONS TABLE #################
Reservation.create(user_id: User.all[0].id, hotel_id: Hotel.all[4].id, start_date: Date.new(2020,8,13), end_date: Date.new(2020,8,16))
Reservation.create(user_id: User.all[1].id, hotel_id: Hotel.all[5].id, start_date: Date.new(2020,4,10), end_date: Date.new(2020,4,20))  
Reservation.create(user_id: User.all[0].id, hotel_id: Hotel.all[1].id, start_date: Date.new(2020,9,14), end_date: Date.new(2020,9,15))
Reservation.create(user_id: User.all[3].id, hotel_id: Hotel.all[0].id, start_date: Date.new(2020,1,1), end_date: Date.new(2020,1,3))  
Reservation.create(user_id: User.all[3].id, hotel_id: Hotel.all[2].id, start_date: Date.new(2020,7,28), end_date: Date.new(2020,8,10))  