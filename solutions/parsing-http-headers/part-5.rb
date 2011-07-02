require 'test/unit'
require 'part-4'

class ResponseTest < Test::Unit::TestCase
  def setup
    @response = Response.new
  end
  
  def test_status_line_is_properly_parsed
    @response.parse("HTTP/1.1 200 OK")
    assert_equal 200, @response.status_code
    assert_equal 'OK', @response.status_message
  end
  
  def test_headers_regression
    examples do |input, expected|
      response = Response.parse(input)
      assert_equal expected, response.headers
    end
  end
  
  private
  
  def examples
    examples_directory = File.expand_path('../../../exercises/parsing-http-headers/examples', __FILE__)
    Dir.glob(File.join(examples_directory, '*.txt')).each do |example_file|
      expected_file = File.expand_path("../../expected/#{File.basename(example_file)}", example_file)
      yield [File.read(example_file), eval(File.read(expected_file))]
    end
  end
end