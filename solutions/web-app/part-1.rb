require 'rubygems'
require 'sinatra'
require 'erb'

# The configure block only runs once for the application
configure do
  set :views, File.expand_path('../templates-part-1', __FILE__)
end

# Route incoming GET requests to / to this block and render the index page
get '/' do
  erb :index
end