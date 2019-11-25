require 'json'
require 'open-uri'
require 'slack-ruby-client'
require '.\config.rb'

TOKEN = $xoxp_API_TOKEN

class WeatherForecastAnnounce
     def set_client( cli )
        @client = cli
     end

     def initialize()
        @latest_fetch_day = -1
        @day = -1
        @weather = ""
        @temperaturel = ""
     end

     def on_hello()
       start_tick()
     end
     
     def fetch_weather_information
      uri         = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=130010'
      res         = JSON.load(open(uri).read)
      title       = res['title']
      link        = res['link']
      weather     = res['forecasts'].first
      @wfa_message= "#{weather['date']}の#{title}は「#{weather['telop']}」です。
      \n詳しい情報は#{link}\n"

      return @wfa_message
     end

     def start_tick()
      thread = Thread.new do
         loop do
            t = Time.now
            if( t.hour == 16 && t.min == 57 && @latest_fetch_day != t.day )
               @latest_fetch_day = t.day
               wi = fetch_weather_information
               @web_client  = Slack::Web::Client.new( token: TOKEN )
               @web_client.chat_postMessage( channel: $user_id, text:"#{wi}", as_user: false)
               #@client.message( channel: 'DQ1FBSYKA', text:"#{wi}")
            end
            sleep( 1 )
         end
      end
     end
    
     def send_message( ch, msg )
        @client.message channel: ch, text: msg
     end

     def  on_message(ch, msg)
       if msg.include?('天気')
          send_message( ch, "天気")
       end    
     end
end