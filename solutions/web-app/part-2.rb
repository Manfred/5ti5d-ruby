require 'rubygems'
require 'sinatra'
require 'erb'
require 'datamapper'

configure do
  set :views, File.expand_path('../templates-part-2', __FILE__)
  
  # Set the database connection
  DataMapper::setup(:default, "sqlite3://#{File.expand_path('../part-2.db', __FILE__)}")
end

# Define a message class to store a message
class Message
  include DataMapper::Resource
  property :id, Serial
  property :body, Text
  property :created_at, DateTime
end

# Finalize tells DataMapper we're not defining any more models
DataMapper.finalize
# Auto upgrade automatically migrates the database schema to fix
# the model definitions
DataMapper.auto_upgrade!

get '/' do
  @message = Message.new
  erb :index
end

# Route incoming POST request to / to this block. Create a new message with
# the incoming parameters, save, and redirect back to the frontpage.
post '/' do
  @message = Message.new(params[:message])
  @message.save
  redirect to('/')
end