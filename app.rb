
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do 
	db = get_db
	db.execute 'CREATE TABLE "Users"( "id" INTEGER PRIMARY KEY AUTOINCREMENT, "name" TEXT , "phone" TEXT, "note" TEXT, "barber" TEXT)'
	
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end
get '/showusers' do 
	db=SQLite3::Database.new 'barbershop.sqlite'
	db.execute 'select * from Users' do |row|
		@ro = row
	end


	erb :showusers
end



get '/About' do 
	erb :About 
end 

get '/visit' do

	erb :visit 	
end 

post '/visit' do 
	@name   =  params[:name]
	@phone  =  params[:phone]
	@note   =  params[:note]
	@barber =  params[:barber]

	hh = {:name => 'Ведите имя', 
		:phone => 'Телефон', 
		:note => 'время' }

	hh.each do |key , value|
		if params[key] == ''
			@error = hh[key]
			return erb :visit 
		end
	end

	db = get_db
	db.execute 'insert into Users (name, phone, note, barber) 
	 values (?, ?, ?, ?)',[@name, @phone, @note, @barber]
	erb "Ok! Name: #{@name}, phone: #{@phone}, время запси #{@note}, barber #{@barber}"		
end 	

get '/contact' do 

	erb :contact
 
end 

def get_db
	return SQLite3::Database.new 'barbershop.sqlite'
end 