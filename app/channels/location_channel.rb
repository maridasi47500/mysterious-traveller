class LocationChannel < ApplicationCable::Channel
    def subscribed

          stream_from "location_channel"
            end

      def unsubscribed
           # Any cleanup needed when channel is unsubscribed
           end
        
             def sayhi(data)
                 p data
                     if data['user']
        
                         bypass_sign_in(User.find(data['user']))
                             User.find(data['user']).appear(data['nbpages'])
                                 else
                                    User.first.disappear(data['nbpages'])
                                          if current_user
                                           sign_out(current_user)
                                             current_user.disappear(data['nbpages'])
                                                   end 
                                                       end
                                                         end
                                                         end
