require 'rubygems'
require 'sinatra'
require 'erb'

configure do
  set :views, File.expand_path('../templates-part-1', __FILE__)
end

get '/' do
  erb :index
end