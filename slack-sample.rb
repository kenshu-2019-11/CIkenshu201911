a = 1

if  (1 == a)
   loop do 
      time = Time.now
      sleep(1)
      p time
   end 
end





















=begin
require 'slack-ruby-client'
require 'json'
require 'open-uri'


time = Time.now

uri         = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=130010'
res         = JSON.load(open(uri).read)
title       = res['title']
link        = res['link']
weather     = res['forecasts'].first
wfa_message = "#{weather['date']}の#{title}は「#{weather['telop']}」です。\n 詳しい情報は#{link}です。"


thread1 = Thread.new do
  puts "asdfghjk"
  if time.hour == 14 && time.min == 4  ||  time.hour == 11 && time.min == 9
    TOKEN = "API_TOKEN"
    web_client = Slack::Web::Client.new( token: TOKEN )
    web_client.chat_postMessage( channel: 'DQ1FBSYKA', text:"#{wfa_message}", as_user: false)
  end
end
thread1.join
=end

#指定した時間に天気を送るサンプルコード
=begin
every(1.day, 'test', at:'10:17') do 
  TOKEN = "API_TOKEN"
  web_client = Slack::Web::Client.new( token: TOKEN )
  web_client.chat_postMessage( channel: 'DQ1FBSYKA', text:'Hello World!!', as_user: false)
end
=end

=begin
Slack.configure do |conf|
  conf.token = 'API_TOKEN'
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts 'connected!'
  client.message channel: 'your_channel_id', text: 'connected!'
end


client.on :message do |data|
  if data['text'].include?('こんにちは')
    client.message channel: data['channel'], text: "Hi!"
  end
  if data['text'].include?('かしこい') || data['text'].include?('えらい')
    client.message channel: data['channel'], text: "Thank you!"
  end
  if data['text'].include?('おやすみ')
    client.message channel: data['channel'], text: "Good night"
  end
end

client.start!
=end