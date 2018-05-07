class UserController < ApplicationController

	get '/' do
		redirect '/user/login'
	end

	get '/login' do
		erb :login
	end

	get '/register' do
		erb :register
	end
	get '/logout' do
		session[:user_id] = nil
		session[:logged_in] = false
		session[:user_id] = @user.id
		redirect '/user/login'
	end

	post '/login' do
		@pw = params[:password]
		@user = User.find_by(username: params[:username])

		if @user && @user.authenticate(@pw)
			session[:username] = @user.username
			session[:logged_in] = true
			session[:message] = "Logged in as #{@user.username}"
			session[:user_id] = @user.id
			redirect '/items'
		else
			session[:message] = "Invalid username or password."
			redirect '/user/login'
		end
	end

	post '/register' do
		@user = User.new
		@user.username = params[:username]
		@user.password = params[:password]
		@user.save
		session[:logged_in] = true
		session[:username] = @user.username
		session[:message] = "Thank you for registering (as #{@user.username}).  Enjoy the site!"
		session[:user_id] = @user.id
		redirect '/items'
	end

end