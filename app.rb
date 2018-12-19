#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "hello"
end

get '/new' do
	erb :new
end

post '/new' do
		@content = params[:content]
			if @content.length <= 0
				@error = "Typed text"
			end

end
