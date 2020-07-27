


response = Unirest.get "https://airbnb-com.p.rapidapi.com/listings/nearby/40.750134/-73.997009",
  headers:{
    "X-RapidAPI-Host" => "airbnb-com.p.rapidapi.com",
    "X-RapidAPI-Key" => ENV['airbnb_key']
  }
  data = response.body


  #   url = URI("https://airbnb-com.p.rapidapi.com/listings/nearby/40.750134/-73.997009")

  # http = Net::HTTP.new(url.host, url.port)
  # http.use_ssl = true
  # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  # request = Net::HTTP::Get.new(url)
  # request["x-rapidapi-host"] = 'airbnb-com.p.rapidapi.com'
  # request["x-rapidapi-key"] = ENV['airbnb_key']

  # #response = http.request(request)
  # data = JSON.parse(http.request(request).body)
