#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 3}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber <ActiveRecord::Base
end

class Contact <ActiveRecord::Base
end

before do
	@barbers= Barber.all
end


get '/' do
	
	erb :index
end

get '/visit' do
	@c = Client.new
	erb :visit
end

post '/visit' do

	@c = Client.new params[:client]
	if @c.save
		erb "<h3>Спасибо, вы записались</h3>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end

	#lame way:
	 # @username = params[:username]
	 # @phone = params[:phone]
	 # @datetime = params[:datetime]
	 # @barber = params[:barber]
	 # @color = params[:color]

	 # Client.create :name => @username, 
		# 		 	:phone => @phone, 
		# 		 	:datestamp => @datetime,
		# 		 	:barber => @barber,
		# 		 	:color => @color
	 
	

end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
	@username = params[:username]
	@text = params[:text]

	Contact.create :name => @username, :text => @text
	erb "<h3>Спасибо, сообщение принято</h3>"
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end

get '/bookings' do
	@clients = Client.order('created_at DESC')
	erb :bookings
end