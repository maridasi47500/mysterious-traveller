require 'uri'

class WelcomeController < ApplicationController
protect_from_forgery except: [:editsettingsaccount,:findconnecte,:findnewconnected,:selectpicturetosend,:refreshchatinterlocutor,:deleteinterlocutor,:sendsmiley,:loadphotos,:loademoticons,:sendmessage,:abuse,:addtoblacklist,:removefromblacklist, :addtofavorites, :deletefromfavorites, :ratinguser,:settingsinterestsme,:profilepic,:deletephoto,:moveotheralbum,:addpublic,:addprivate,:updateuserpicture,:createaccount,:viplogin]
before_action :authen, except: [:createaccount,:index,:register,:findconnecte,:login, :viplogin]
before_action :find_user, only: [:selectpicturetosend,:refreshchatinterlocutor,:deleteinterlocutor,:sendsmiley,:sendmessage,:abuse,:addtoblacklist,:removefromblacklist, :addtofavorites, :deletefromfavorites]
layout "lysearch"
include CGI::Util
def findconnecte
session[:newconnected] = {:range_1 => "18", :range_2 => "99", :chattername => "", :serious=>"0",:fun=>"0",:friendship=>"0",:mansearched=>"0", :womansearched=>"0", :publicmed=>"0", :profilepic=>"0"}
end
def editsettingsaccount
 current_user.update(my_connected_params)
@noerror = current_user.errors.messages.to_a.length == 0
render :settingsaccount

end
def findnewconnected
j=my_connected_params
p j
p session[:newconnected]
session[:newconnected] ||= {}
session[:newconnected]=session[:newconnected].merge(j)
session[:newconnected].delete_if { |k,v| v == "" }
session[:newconnected].compact!
p session[:newconnected]
u=User.new(session[:newconnected])
session[:newconnected].delete_if { |k,v| k == "first" || k == "previous" || k == "next" }
u.myfunc

@users=u.searchnewconnected.to_a
session[:newconnected]=session[:newconnected].merge({nbconnected: @users.length, myoffset: u.myoffset})

p @users
render layout: false, locals: {nbpage: @users[0].try(:mynbpage).to_i, myoffset: (u.myoffset.to_i)}
end
def selectpicturetosend
@message= Message.new(mypic:params[:photo_id], sender: current_user, receiver: @user)
if @message.save
render inline: "ok", layout: false
else
p @message.errors
render inline: "0", layout: false
end
end
def refreshchatinterlocutor
render partial: "messages/message", collection: @user.allmessages, layout: false
end
def deleteinterlocutor
if @user.exchangedmessagesdeleteall || @user.exchangedmessagesalldeleted
render inline: "ok", layout: false
else
render inline:"0", layout: false
end
end
def sendsmiley
@emoji=Emoji.all[(params[:smiley].to_i - 1)].try(:code)
if @emoji
#.gsub("\\","&#")+";")
p @emoji.gsub("\\","\\u").html_safe, layout: false
render inline: (@emoji.gsub("\\","&#x")+";"), layout: false
else
render inline: "0", layout: false 
end

end
def loademoticons
render partial: "emoticons", layout: false
end
def loadphotos
render partial: "mediastosend", layout: false
end
def sendmessage
@message=Message.new(content: params[:content], sender: current_user, receiver: @user)
if @message.save
  MessageBroadcastJob.perform_later(@message, @message.receiver_id)
render partial: "welcome/cansendmessage", layout: false
else
render inline: "0", layout: false 
end
end
def abuse
current_user.abuses << @user
end
def addtoblacklist
current_user.favorites.delete(@user) 
current_user.blacklisted << @user
end
def removefromblacklist
current_user.blacklisted.delete(@user) 
end
def addtofavorites
current_user.blacklisted.delete(@user) 
current_user.favorites << @user
end
def deletefromfavorites
current_user.favorites.delete(@user) 

end
def ratinguser
@user=User.find(params[:id])
@rating = Rating.new(rating_params.merge(notinguser_id: current_user.id))
if @rating.save
render inline: params[:rating]
else
render inline: "0"
end

end
def settingsinterestsme
current_user.update(interest_params)
redirect_to settingsinterests_path
end
def moveotheralbum
@photo=Photo.find(params[:id])
current_user.moveotheralbum(@photo)
render inline: "ok", layout: false
end
def profilepic
@photo=Photo.find(params[:id])
current_user.changeprofilepic(@photo)
render inline: "ok", layout: false
end
def deletephoto

@photo=Photo.find(params[:id])
p @photo
p Photo.all.pluck(:url)
if @photo && @photo.destroyphoto && @photo.destroy
render inline: "ok", layout: false
else
render inline: "0", layout: false
end

end
def addpublic
@image=Photo.new(pic_params)
if @image.save
current_user.publicphotos << @image
render layout: false, partial: "myphotos", locals: {image: @image}
else
render inline: "0", layout: false
end
end
def addprivate
@image=Photo.new(pic_params)
if @image.save
current_user.privatephotos << @image
render layout: false, partial: "myprivatephotos", locals: {image: @image}
else
render inline: "0", layout: false
end
end
    def myprofileuser
        
        @user=User.find(params[:id])
        if @user.id == current_user.id
            render :profileuserme
            else
            render :myprofileuser
            end
    end
  def homecontact
    render layout: "lyhomecontact"
  end  
  def page1
    @u=User.new(session[:newconnected])
    @users=@u.searchnewconnected
    render :findnewconnected, layout: "laysearch", locals: {nbpage: @users[0].try(:mynbpage).to_i, myoffset: (@u.myoffset.to_i)}
  end 
  def followers
    @followers=current_user.myfollowers
    render layout: "lysearch"
  end 
  def favorites
    @favorites=current_user.myfavorites
    render layout: "lysearch"
  end  
  def conversations
    @newconversations=current_user.currentconversations
    
    render layout: "lysearch"
  end
  def map
    render layout: "lysearch"
  end  
  def settingsvip
    current_user.initializevalues

    render layout: "lysearch"
  end  
  def settingsvipme
    current_user.update(userscope_params)
    p current_user.errors
    render :settingsvip, layout: "lysearch"
  end  
    def settingsaccount
    render layout: "lysearch"
    end
    def settingsalbums
    render layout: "lysearch"
    end
    def settingsalbums
    render layout: "lysearch"
    end
    def settingsinterests
    render layout: "lysearch"
    end
def settingsdating
    current_user.initializevalues
    render layout: "lysearch"

end
def settingsdatingme
    current_user.update(userscope_params)
    p current_user.errors
    p current_user.userrelationships.each {|x|p x.errors} 
    render :settingsdating
end
  def mesmessages
    @newmessages=current_user.newinterlocutors
    render layout: "lysearch"
  end
  def tchatche
@user = User.find(params[:id])
@newmessages = []
	@messages=Message.findby(current_user.id, params[:id]) rescue []
    render layout: "lysearch"

    #render layout: "lysearch"
  end  
    def search
    render layout: "lysearch"

    end
	
  def index

  end
  def login
    render layout: "viplogin" 
  end
  def register
    @user=User.new
  end
  def createaccount 
    @user=User.new(user_params.merge(online: true))
    if @user.save
	bypass_sign_in(@user)
        redirect_to tracechat_path
    else
	p @user.errors

        render :register
    end    
  end
  def viplogin
    @user=User.find_by(name: params[:Name])
    if @user && @user.valid_password?(params[:Password])

	bypass_sign_in(@user)
	@user.appear(0)
        redirect_to tracechat_path
    else
        p "PASSWORD INVALID"
        redirect_to accountviplogin_path
    end
  end
    def updateuserpicture
        if current_user.update(userscope_params)
        render partial: 'userspic', locals: {user: current_user}, layout: false
        else
        render inline: "0",layout: false
        end
    end
  private
  def userscope_params
    params.permit("userpic", "Country", "Subdivision","Description","Weight", "Height","DontShowOnProfile","DatingSearchedFun","DatingSearchedFriendly", "DatingSearchedSerious", "GenderSearchedMan", "GenderSearchedWoman",:Gender, :MaleSearched,:FemaleSearched,:Month,:Day,:Year,:Email,:PhoneNumber,:Latitude,:Longitude,:Name,:Password,:fake_country,:Country,:OptIn,:termsCgu,:termsPrivacy)

  end  
  def user_params
    params.require(:user).permit("DatingSearchedFun","DatingSearchedFriendly", "DatingSearchedSerious", "GenderSearchedMan", "GenderSearchedWoman",:Gender, :MaleSearched,:FemaleSearched,:Month,:Day,:Year,:Email,:PhoneNumber,:Latitude,:Longitude,:Name,:Password,:fake_country,:Country,:OptIn,:termsCgu,:termsPrivacy)
end
def interest_params
params.permit("Interests" => {})

  end  
    def pic_params
params.permit("userpic")
end
  def connexion_params
    params.permit("Name", "Password")
  end
def authen
if !user_signed_in?
redirect_to accountviplogin_path
end
 
end
def myphoto_params
params.permit(:url)
end
def rating_params
params.permit(:user_id, :rating)
end
def find_user
@user=User.find(params[:id])
@u=User.new(session[:newconnected])
@users=@u.searchnewconnected
end
def my_connected_params
params.permit(:nbconnected,:first,:next,:previous,:Password,:Month,:Day,:Year,:range_1, :range_2, :chattername, :IsGops, :WantsToRegister,:serious,:fun,:friendship,:mansearched, :womansearched, :publicmed, :profilepic)
end
end
