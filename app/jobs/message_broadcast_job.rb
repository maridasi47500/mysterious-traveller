class MessageBroadcastJob < ApplicationJob

  queue_as :default


  def perform(message)

    ActionCable.server.broadcast 'room_channel', message: render_message(message), messagereceiver: message.receiver_id

  end


  private


  def render_message(message)

    ApplicationController.renderer.render(partial: 'messages/messagesent', locals: { message: message,layout: false })

  end

end
