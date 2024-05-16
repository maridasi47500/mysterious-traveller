class RoomChannel < ApplicationCable::Channel
    def subscribed
          stream_from "room_channel"
            end

      def unsubscribed
           # Any cleanup needed when channel is unsubscribed
           end
        
             def speak(data)
        
                 #ActionCable.server.broadcast "room_channel", message: data['message']
                     #Message.create! data
                       p "data"
                            p data
                                @message=Message.new mycontent: data['message']
                                     @message.save
                                         @message 
                                           end
                                           end
