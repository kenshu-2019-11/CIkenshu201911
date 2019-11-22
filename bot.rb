require 'slack-ruby-client'
require '.\greet_reply.rb'
require '.\weather_forecast_announce.rb'
require '.\schedule_notice.rb'

class Bot

  def initialize()
    @name = "name"
    @token = "API_TOKEN"
    @channel = "channel"

    Slack.configure do |config|
      config.token = @token
    end
    
    @client = Slack::RealTime::Client.new
    
    @client.on :hello do
      on_hello()
      puts 'connected!'
    end    

    
    @client.on :message do |data|
      on_message( data['channel'], data['text'] )
    end
    
    @function_list = [
      GreetReply.new(),
      WeatherForecastAnnounce.new(),
#      ScheduleNotice.new()
    ]

    initialize_function()
    
    @client.start!
  end

  def send_message( ch, msg )
    @client.message channel: ch, text: msg
  end

  def initialize_function()
    @function_list.each do |f|
      f.set_client( @client )
    end
  end

  def on_hello()
    puts "Bot: on_hello"
    @function_list.each do |f|
      f.on_hello()
    end
  end


  def on_message( ch, msg )
    @function_list.each do |f|
      f.on_message( ch, msg )
    end
  end
end
b = Bot.new