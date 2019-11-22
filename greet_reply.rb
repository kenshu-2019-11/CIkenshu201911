class GreetReply
  
  def initialize()
    @client = nil
  end
  
  def greet()

  end

  def on_hello()
    puts "-- GreetReply: on_hello"
   end

  def set_client( cli )
    @client = cli
  end

  def send_message( ch, msg )
    @client.message channel: ch, text: msg
  end


  def on_message( ch, msg )
    if msg.include?('こんにちは')
      send_message( ch, "Hi!" )
    end
    if msg.include?('かしこい') || msg.include?('えらい')
      send_message( ch, "Thank you!" )
    end
    if msg.include?('おやすみ')
      send_message( ch, "Good night" )
    end
   end
end
