class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	ActiveRecord::Base.establish_connection(
 		:adapter => 'postgresql', 
 		:database => 'item'
	)

	set :views, File.expand_path('../views', 'hello.erb')


	get '/' do
		@page = "hello"
  		erb :hello
  	end

end