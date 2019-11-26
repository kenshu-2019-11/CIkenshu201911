class Greeting
  
  def initialize()
    @client = nil
  end

  def on_hello()
  end

  def set_client( cli )
    @client = cli
  end

  def send_message( ch, msg )
    @client.message channel: ch, text: msg
  end


  def on_message( ch, msg )
    if msg.include?('おはよう')
      send_message( ch, "おはようございます!" )
    end
    if msg.include?('こんにちは')
      send_message( ch, "こんにちは!" )
    end
    if msg.include?('ありがとう')
      send_message( ch, "どういたしまして!" )
    end
    if msg.include?('かしこい') || msg.include?('えらい')
      send_message( ch, "ありがとうございます!" )
    end
    if msg.include?('おやすみ')
      send_message( ch, "おやすみなさい。" )
    end
   end
end
