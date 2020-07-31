class Geocode

  @key = ENV['geocode_key']
  
  def self.start
    Hotel.delete_all
    puts "\n\nPlease Enter where you would like to search."
    puts "It must be formated 'CITY, STATE' for example (New York City, NY)\n\n"
    user_input = gets.chomp.strip
    begin
      u1 = user_input.split(',')
      city_1 = u1[0]
      state_1 = u1[1]
      city = city_1.strip
      state = state_1.strip
    rescue NoMethodError
      puts "\n\nINVALID INPUT\n\n"
      Geocode.start
    end
    #binding.pry
    Geocode.search_by_city_and_state(city, state)
  end
  
  def self.search_by_city_and_state(city, state)
    geocode_response = Unirest.get "https://api.opencagedata.com/geocode/v1/json?q=#{city}%2C%20#{state}&key=#{@key}&language=en&pretty=1"
    parsed = geocode_response.body
    lat = parsed["results"][0]["geometry"]["lat"]
    lng = parsed["results"][0]["geometry"]["lng"]
    
    response = Unirest.get "https://airbnb-com.p.rapidapi.com/listings/nearby/#{lat}/#{lng}",
    headers:{
    "X-RapidAPI-Host" => "airbnb-com.p.rapidapi.com",
    "X-RapidAPI-Key" => ENV['airbnb_key']
    }
    data = response.body
    data["listings"].each do |listing|
      Hotel.create(name: listing["listing"]["name"], price: listing['pricing_quote']['rate']['amount'], beds: listing["listing"]["beds"], guest_amount: listing["listing"]["guest_label"], neighborhood: listing["listing"]["localized_neighborhood"], city: listing["listing"]["localized_city"])
    system('rake db:seed')
    end
  end
end