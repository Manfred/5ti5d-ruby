# encoding: utf-8

require 'time'
require 'pp'

# Define a hash with the header names and their types
HEADERS_TYPE_MAP = {
  'date'           => :time,
  'content-length' => :integer
}

# Define a method that casts header values
def type_cast(header_name, header_value)
  # Find the type for the headers name, this will result in either a value
  # or the special nil value.
  case HEADERS_TYPE_MAP[header_name]
  when :time
    # The time class can parse the value for us
    Time.parse(header_value)
  when :integer
    # Strings can be cast directly to an integer
    header_value.to_i
  when nil
    # When we don't want to do anything special with the header we just
    # pass it along.
    header_value.strip
  else
    # Raise an argument error when we defined a type in the type map which
    # we can't handle.
    raise ArgumentError, "Unknown header type `#{header_type.inspect}'"
  end
end

def parse_headers(input)
  input.split("\n").inject({}) do |headers, line|
    header_name, header_value = line.split(":", 2)
    unless header_value.nil?
      header_name = header_name.downcase
      # Instead of directory assigning the value we now first type-cast it
      headers[header_name] = type_cast(header_name, header_value)
    end
    headers
  end
end

examples_directory = File.expand_path('../../../exercises/parsing-http-headers/examples', __FILE__)

Dir.glob(File.join(examples_directory, '*.txt')).each do |filename|
  puts
  puts File.basename(filename)
  pp parse_headers(File.read(filename))
end