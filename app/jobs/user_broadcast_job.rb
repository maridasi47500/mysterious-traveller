class UserBroadcastJob < ApplicationJob
include Rails.application.routes.url_helpers
  queue_as :default


  def perform(user,currentuserid)
    ActionCable.server.broadcast 'location_channel', userid: user.id, user: render_user(user), online: (user.online ? "yes" : "no"), urluser: ('[href="'+tchatchepass_path(id: user.id)+'"]'), nbusers: User.nbonline, mapage: 1, nbonlinefirstpart:User.nbpageonline1, nbonlinesecondpart: User.nbpageonline2, newinterlocutors: User.find(currentuserid).nbnewinterlocutors

  end


  private


  def render_user(user)

    ApplicationController.renderer.render(partial: 'application/interlocutor', locals: {user: user} )

  end

end
