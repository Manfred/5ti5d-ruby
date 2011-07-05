require 'rubygems'
require 'sinatra'
require 'erb'
require 'datamapper'

configure do
  set :views, File.expand_path('../templates-part-3', __FILE__)
  
  DataMapper::setup(:default, "sqlite3://#{File.expand_path('../part-3.db', __FILE__)}")
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
  @messages = Message.all(:order => [:created_at.desc])
  erb :index
end

post '/' do
  @message = Message.new(params[:message])
  @message.save
  redirect to('/')
end