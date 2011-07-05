require 'rubygems'
require 'sinatra'
require 'erb'
require 'datamapper'

configure do
  set :views, File.expand_path('../templates-part-4', __FILE__)
  
  DataMapper::setup(:default, "sqlite3://#{File.expand_path('../part-4.db', __FILE__)}")
end

class Message
  include DataMapper::Resource
  property :id, Serial
  property :body, Text
  property :created_at, DateTime
  
  validates_presence_of :body, :message => "Please type a message"
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
  # When validations fail, save returns false
  if @message.save
    redirect to('/')
  # Render the frontpage with errors when there are validation messages
  else
    erb :index
  end
end