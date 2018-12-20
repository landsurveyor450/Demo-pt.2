#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
		@db = SQLite3::Database.new 'dot.db'
end

		before do
				init_db
		end

configure '/' do
		init_db
	@db.execute 'CREATE TABLE IF NOT EXISTS Posts (
	id	INTEGER ,
	created_date	DATA,
	content	TEXT
)'
@db.execute 'CREATE TABLE IF NOT EXISTS Comments (
	id	INTEGER ,
	created_date	DATA,
	content	TEXT,
	post_id INTEGER
)'

end

get '/' do
		@results = db.execute 'select * from Posts order by id desc'
	erb :index
end

get '/new' do
	erb :new
end
#создаем базу данных для получения информации от new.erb
post '/new' do
		content = params[:content]
			if content.length <= 0
				@error = "Typed text"
				return erb :new
			end
					@db = execute 'insert into Posts (content, create_date) values (?, date_time())',[content]

					redirect to '/'
end

get '/details/:post_id' do
	post_id = params[:post_id]
		content = params[:content]
		@db.execute 'insert into Comments (content, created_date, post_id) values (?, datetime(),?)',[content]
		redirect to('/details/' + post_id)
end
