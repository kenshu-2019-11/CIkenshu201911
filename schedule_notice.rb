class ScheduleNotice
    def set_client( cli )
        @client = cli
    end
    
    def initialize()
        @day = -1
        @weather = ""
        @temperaturel = ""
    end

    def send_message( ch, msg )
        @client.message channel: ch, text: msg
    end
    
    
    def  on_message(ch, msg)
        if msg.include?('今日の予定')
            send_message( ch, "今日の予定はありません" )
        end    
    end
end