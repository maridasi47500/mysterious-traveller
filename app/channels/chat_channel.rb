class ChatChannel < ApplicationCable::Channel
    #rescue_from 'MyError', with: :deliver_error_message
  
  
    # Called when the consumer has successfully
      # become a subscriber to this channel.
        def subscribed
            stream_from "chat_#{params[:room]}"
  
              end
              private
  
                #def deliver_error_message(e)
                  #  broadcast_to(...)
                    #end
  
                    end
