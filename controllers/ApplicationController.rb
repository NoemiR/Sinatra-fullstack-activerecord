class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	enable :sessions

	ActiveRecord::Base.establish_connection(
 		:adapter => 'postgresql', 
 		:database => 'item'
	)
	set :public_dir, File.expand_path('../public', File.dirname(__FILE__))
	set :views, File.expand_path('../views', 'hello.erb')

	use Rack::MethodOverride  # we "use" middleware in Rack-based libraries/frameworks
	set :method_override, true


	get '/' do
		@page = "hello"
		# binding.pry
  		erb :hello
  	end

end