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
	erb "hello"
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
					db = execute 'insert into Posts (content, create_date) values (?, date_time())',[content]

					redirect to '/'
end
