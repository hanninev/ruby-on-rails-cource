require "rubygems"
require "json"

class WeatherApi
  def self.get_weather_in(city)
    url = "http://api.apixu.com/v1/current.json?key=#{key}&q="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"

    JSON.parse(response.body)
  end

  def self.key
    "6b60dd65e9ba45cb9e8201621180710"
  end
end
