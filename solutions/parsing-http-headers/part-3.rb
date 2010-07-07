# encoding: utf-8

require 'time'

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
    header_value
  else
    # Raise an argument error when we defined a type in the type map which
    # we can't handle.
    raise ArgumentError, "Unknown header type `#{header_type.inspect}'"
  end
end

def parse_headers(input)
  input.split("\n").inject({}) do |headers, line|
    parts = line.split(":")
    if parts.length > 1
      header_name = parts[0].downcase
      header_value = parts[1..-1].join(':').strip
      
      # Instead of directory assigning the value we now first type-cast it
      headers[header_name] = type_cast(header_name, header_value)
    end
    headers
  end
end

examples_directory = File.expand_path('../../../exercises/parsing-http-headers/test/examples', __FILE__)

Dir.entries(examples_directory).each do |name|
  if name =~ /\.txt$/
    input = File.read(File.join(examples_directory, name))
    puts name
    p parse_headers(input)
  end
end