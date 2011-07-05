require File.expand_path('../part-4', __FILE__)

# The test/unit library is the standard Ruby unit testing library
require 'test/unit'
# Rack/test is a general purpose testing framework for web frameworks based
# on Rack
require 'rack/test'

# Make sure we run in test environment
ENV['RACK_ENV'] = 'test'

class MessageTest < Test::Unit::TestCase
  # Rack::Test::Methods includes important helper methods
  # like get, post, last_response, etc.
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  def test_index_show_a_form
    get '/'
    assert last_response.ok?
    assert last_response.body =~ /\<form/
  end
  
  def test_visitor_posts_a_message
    message_count = Message.count
    post '/', :message => { :body => 'Hi!' }
    assert last_response.redirect?
    assert_equal('http://example.org/', last_response.headers['Location'])
    assert_equal(message_count + 1, Message.count)
  end
end