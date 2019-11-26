require 'json'
require 'open-uri'
require 'slack-ruby-client'
require '.\config.rb'

uri         = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=130010'
res         = JSON.load(open(uri).read)
title       = res['title']
link        = res['link']
weather     = res['forecasts'].first
temperature = weather['temperature']
max         = temperature['max'] 
min         = temperature['min'] 

puts  "#{weather}"