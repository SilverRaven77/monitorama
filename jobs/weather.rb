require 'net/http'
require 'json'


# API KEY
# https://openweathermap.org/api
access_token = "2427e3191d0fe4001a764b05714d56a7"
url = 'http://api.openweathermap.org/data/2.5/weather'
# Units :
 ## metric for celcius
 ## standard for fahrenheit
units = 'metric'

##
#English - en, Russian - ru, Italian - it, Spanish - es (or sp), Ukrainian - uk (or ua), German - de, Portuguese - pt, Romanian - ro, Polish - pl, Finnish - fi, Dutch - nl, French - fr, Bulgarian - bg, Swedish - sv (or se), Chinese Traditional - zh_tw, Chinese Simplified - zh (or zh_cn), Turkish - tr, Croatian - hr, Catalan - ca
#Arabic (ar); Czech (cz); Greek (el); Persian (Farsi) (fa); Galician (gl); Hungarian (hu); Japanese (ja); Korean (kr); Latvian (la); Lithuanian (lt); Macedonian (mk); Slovak (sk); Slovenian (sl); Vietnamese (vi).
lang = 'en'

# City for which you want to display the weather
city = 'Reisbach'

SCHEDULER.every '1m', :first_in => 0 do |job|
  uri = URI(url + '?q=' + city + '&lang=' + lang + '&units=' + units + '&appid=' + access_token)
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)
  temp = data['main']['temp']
  desc = data['weather'][0]['description']
  icon = data['weather'][0]['icon']
  send_event('weather', { :temp => temp.to_i.to_s + '°C',
                          :condition => desc.capitalize(),
                          :title => data['name'],
                          :climacon => climacon_class(icon)})
end


def climacon_class(icon)
  case icon
  when '50d' 
    'fog'
  when '50n'
    'fog'
  when '11d' 
    'lightning'
  when '11n' 
    'lightning'
  when '10d' 
    'rain'
  when '10n' 
    'rain'
  when '09d' 
    'rain'
  when '09n' 
    'rain'
  when '04d' 
    'cloud'
  when '04n' 
    'cloud'
  when '03d' 
    'cloud'
  when '03n' 
    'cloud'
  when '02d' 
    'cloud sun'
  when '02n' 
    'cloud moon'
  when '01n' 
    'moon'
  when '01d' 
    'sun'
  end
end
