require 'slack-ruby-client'

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
  client.start
