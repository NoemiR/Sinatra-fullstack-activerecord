class ItemController < ApplicationController
	
	# this is called a filter and will be run before all requests in this route
	before do
		if !session[:logged_in]
			session[:message] = "You must be logged in to do that"
			redirect '/user/login'
		end
	end
	# index route
	get '/' do
		@items = Item.all # beautiful isn't it
		# @items.to_json
		@page = "Index of items"
		erb :item_index
  	end


	# add route 
	get '/add' do
		
	# this view will be created in the next step
	@page = "Add Item"
	@action = "/items"
	@method = "POST"
	@placeholder = "Enter your item!"
	@value=""
	@buttontext = "Add Item"
	erb :add_item 
	end
	# create route
	post '/' do

	pp params

	# this is how you add something with ActiveRecord.  
	@item = Item.new
	@item.title = params[:title]
	@item.user_id = 1 # for now
	@item.save
	session[:message] = "You added item \##{@item.id}."

	# hey there's a .to_json method. cool.
	@item.to_json
	redirect '/items'

	end
		delete '/:id' do
		# there are many ways to do this find statement, this is just one
		# remember you can play around with ActiveRecord by adding binding.pry 
		# and trying stuff out
		@item = Item.find params[:id]
		@item.destroy
		session[:message] = "You deleted item \##{@item.id}"
		pp session
		redirect '/items'
	end

	# edit route
	get '/edit/:id' do
		@item = Item.find params[:id]
		@page = "Edit Item #{@item.id}" #why am i using interpolation here?  try with concatenation and see what happens.
		erb :edit_item
	end

	# update route
	patch '/:id' do
		# like i said -- lots of ways to do this.  
		# http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html
		# http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where
		@items = Item.where(id: params[:id]) 

		# note: .where method gives us an array (Why?). So we must index. 
		# Might there have been a more appropriate query method to use 
		# instead of .where ?
		@item = @items[0]

		@item.title = params[:title]
		@item.save
		session[:message] = "You updated item \##{@item.id}"
		redirect '/items'
	end


end