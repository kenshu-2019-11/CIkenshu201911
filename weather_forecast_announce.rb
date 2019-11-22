require 'json'
require 'open-uri'
require 'slack-ruby-client'
TOKEN = "API_TOKEN"

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
       puts "-- WeatherForecastAnnounce: on_hello"
       start_tick()
     end
     
     def fetch_weather_information
      puts "-- WeatherForecastAnnounce: fetch_weather_information()"
      uri         = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=130010'
      res         = JSON.load(open(uri).read)
      title       = res['title']
      link        = res['link']
      weather     = res['forecasts'].first
      @wfa_message = "#{weather['date']}の#{title}は「#{weather['telop']}」です。\n 詳しい情報は#{link}です。"

      return @wfa_message
     end

     def start_tick()
      puts "-- WeatherForecastAnnounce: start_tick(): start"
      thread = Thread.new do
         loop do
            t = Time.now
            p "t.hour = #{t.hour}, t.min = #{t.min}, t.sec = #{t.sec}"
            if( t.hour == 16 && t.min == 9 && @latest_fetch_day != t.day )
               @latest_fetch_day = t.day
               p "t.hour = #{t.hour}, t.min = #{t.min}, t.sec = #{t.sec} !!!"
               wi = fetch_weather_information
               @web_client  = Slack::Web::Client.new( token: TOKEN )
               @web_client.chat_postMessage( channel: 'DQ1FBSYKA', text:"#{wi}", as_user: false)
            end
            sleep( 1 )
         end
      end
#      thread.join
      puts "-- WeatherForecastAnnounce: start_tick(): end"
    end

     def  weather_forecast 
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

