Hotel.delete_all
User.delete_all
Reservation.delete_all


response = Unirest.get "https://airbnb-com.p.rapidapi.com/listings/nearby/40.750134/-73.997009",
  headers:{
    "X-RapidAPI-Host" => "airbnb-com.p.rapidapi.com",
    "X-RapidAPI-Key" => ENV['airbnb_key']
  }
data = response.body
  
#######################################

####### SEEDING THE HOTELS TABLE ######
data["listings"].each do |listing|
    Hotel.create(name: listing["listing"]["name"], price: listing['pricing_quote']['price_string'], beds: listing["listing"]["beds"], guest_amount: listing["listing"]["guest_label"], neighborhood: listing["listing"]["localized_neighborhood"])
end

##################SEED FOR USERS#####################
User.create(first_name:'Brian', last_name:'Lego', email: "brianlego@email.com", password: "1234")
User.create(first_name:'Devin', last_name:'Benson', email: "db@email.com", password: "4567")
User.create(first_name:'Juju', last_name:'Bee', email: "runnerup@email.com", password: "8910")
User.create(first_name:'Alyssa', last_name:'Edwards', email: "dancingelite@email.com", password: "1011")

###### SEEDS FOR RESERVATIONS TABLE #################
Reservation.create(user_id: User.all[0].id, hotel_id: Hotel.all[4].id)
Reservation.create(user_id: User.all[1].id, hotel_id: Hotel.all[5].id)  
Reservation.create(user_id: User.all[2].id, hotel_id: Hotel.all[5].id)
Reservation.create(user_id: User.all[3].id, hotel_id: Hotel.all[0].id)  
Reservation.create(user_id: User.all[3].id, hotel_id: Hotel.all[2].id)  