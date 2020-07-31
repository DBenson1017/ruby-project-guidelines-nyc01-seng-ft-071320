class Geocode

  @key = ENV['geocode_key']
  def self.start
    puts "Please Enter where you would like to search."
    puts "It must be formated 'CITY, STATE' for example (New York City, NY)"
    puts "The STATE may be given by initials (NY) or full name (New York)"
    user_input = gets.chomp.strip
    u1 = user_input.split(',')
    city_1 = u1[0]
    state_1 = u1[1]
    city = city_1.strip
    state = state_1.strip
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
      Hotel.create(name: listing["listing"]["name"], price: listing['pricing_quote']['rate']['amount'], beds: listing["listing"]["beds"], guest_amount: listing["listing"]["guest_label"], neighborhood: listing["listing"]["localized_neighborhood"])
      binding.pry
      system('rake db:seed')
    end
  end
end