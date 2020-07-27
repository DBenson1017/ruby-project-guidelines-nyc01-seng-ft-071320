
class Hotel 



    url = URI("https://airbnb-com.p.rapidapi.com/listings/nearby/40.750134/-73.997009")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-host"] = 'airbnb-com.p.rapidapi.com'
  request["x-rapidapi-key"] = ENV['airbnb_key']

  #response = http.request(request)
  data = JSON.parse(http.request(request).body)

  binding.pry

end