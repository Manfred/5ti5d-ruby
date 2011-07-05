require 'rubygems'
require 'sinatra'
require 'erb'
require 'datamapper'

configure do
  set :views, File.expand_path('../templates-part-2', __FILE__)
  
  DataMapper::setup(:default, "sqlite3://#{File.expand_path('../part-2.db', __FILE__)}")
end

class Message
  include DataMapper::Resource
  property :id, Serial
  property :body, Text
  property :created_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  @message = Message.new
  erb :index
end

post '/' do
  @message = Message.new(params[:message])
  if @message.save
    redirect to('/')
  else
    erb :index
  end
end