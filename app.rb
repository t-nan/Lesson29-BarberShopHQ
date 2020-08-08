#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: 'sqlite3',database: 'barbershop.db'}

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers=Barber.all
end

get '/' do	
	erb :index
end


get '/visit' do
	erb :visit
end

post '/visit' do

  c = Client.new params[:client]
  c.save
 
	erb "<h2>Спасибо,вы записались.</h2>"
end


get '/contacts' do
	erb :contacts
end

post '/contacts' do

	@username = params[:username]
	@phone = params[:phone]
	
 Contact.find_or_create_by(name: "#{@username}",phone: "#{@phone}")
 
	erb "<h2>Контакты сохранены.</h2>"
end