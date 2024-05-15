Rails.application.routes.draw do

post "/Account/VIPLogin", to: "welcome#viplogin"
  get "/Chat/home", to: "welcome#page1"
  get "/Home/Contact", to: "welcome#homecontact"
  get "/Chat/Favorites", to: "welcome#favorites"
  get "/Chat/Followers", to: "welcome#followers"
  get "/Chat/Conversations", to: "welcome#conversations"
  post "/Account/Register", to: "welcome#createaccount"  
  get "/Account/Register", to: "welcome#register"  
  get "/Account/VIPLogin", to: "welcome#login", as: :accountviplogin
get "Chat/search", to: "welcome#search", as: :tracechat
get "/Chat/profile/TchatchePass:id", to: "welcome#myprofileuser", as: :tchatchepass
get "Chat", to: "welcome#search"
get "/Chat/newinterlocutors", to: "welcome#mesmessages", as: :newinterlocutors
get "/Chat/conversation/TchatchePass:id", to: "welcome#tchatche", as: :tchatcheconversation
get "/Chat/map", to: "welcome#map"
get "/Chat/SettingsVIPProfile", to: "welcome#settingsvip" 
patch "/Chat/SettingsVIPProfile", to: "welcome#settingsvipme" 
post "updateuserpicture", to: "welcome#updateuserpicture"
get "/Chat/SettingsDating", to: "welcome#settingsdating" 
patch "/Chat/SettingsDating", to: "welcome#settingsdatingme" 
get "/Chat/SettingsAccount", to: "welcome#settingsaccount" 
get "/Chat/SettingsAlbums", to: "welcome#settingsalbums" 
get "/Chat/SettingsInterests", to: "welcome#settingsinterests", as: :settingsinterests 
post "loademoticons", to: "welcome#loademoticons", as: :loademoticons
post "loadphotos:id", to: "welcome#loadphotos", as: :loadphotos
patch "/Chat/SettingsAccount", to: "welcome#editsettingsaccount", as: :editsettingsaccount
post "findnewconnecte", to: "welcome#findnewconnected", as: :search_new_connected
post "findconnecte", to: "welcome#findconnecte", as: :searchconnect
post "addpublic", to: "welcome#addpublic"
post "addprivate", to: "welcome#addprivate"
post "moveotheralbum", to: "welcome#moveotheralbum"
post "profilepic", to: "welcome#profilepic"
post "deletephoto", to: "welcome#deletephoto"
root 'welcome#index'
post "/api/vips/TchatchePass:id", to: "welcome#ratinguser", as: :rating
post "/api/abuse/TchatchePass:id", to: "welcome#abuse", as: :abuse
post "/api/addtoblacklist/TchatchePass:id", to: "welcome#addtoblacklist", as: :addtoblacklist
post "/api/removefromblacklist/TchatchePass:id", to: "welcome#removefromblacklist", as: :removefromblacklist
post "/api/deletefromfavorites/TchatchePass:id", to: "welcome#deletefromfavorites", as: :deletefromfavorites
post "/api/selectpicturetosend/TchatchePass:id", to: "welcome#selectpicturetosend", as: :selectpicturetosend
post "/api/sendmessage/TchatchePass:id", to: "welcome#sendmessage", as: :sendmessage
post "/api/addtofavorites/TchatchePass:id", to: "welcome#addtofavorites", as: :addtofavorites
post "/api/deleteinterlocutor/TchatchePass:id", to: "welcome#deleteinterlocutor", as: :deleteinterlocutor
post "/api/smiley/TchatchePass:id", to: "welcome#sendsmiley", as: :sendsmiley
post "/api/refreshchatinterlocutor/TchatchePass:id", to: "welcome#refreshchatinterlocutor", as: :refreshchatinterlocutor
patch "/Chat/SettingsInterests", to: "welcome#settingsinterestsme"

devise_scope :user do
post "/Chat/Logout", to: "users/sessions#destroy", as: :logout
end
devise_for :users
mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
