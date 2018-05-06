class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	ActiveRecord::Base.establish_connection(
 		:adapter => 'postgresql', 
 		:database => 'item'
	)

	set :views, File.expand_path('../views', 'hello.erb')

	use Rack::MethodOverride  # we "use" middleware in Rack-based libraries/frameworks
	set :method_override, true


	get '/' do
		@page = "hello"
		# binding.pry
  		erb :hello
  	end

end