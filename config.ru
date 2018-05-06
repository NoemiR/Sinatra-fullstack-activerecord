require 'sinatra/base'
require 'sinatra/activerecord'

# controllers

require './controllers/ApplicationController'
require './controllers/ItemController'
require './models/ItemModel'
# routes

map('/items') { 
	run ItemController
}

map('/') {
	run ApplicationController
}
