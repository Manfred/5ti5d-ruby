# encoding: utf-8

require 'time'

HEADERS_TYPE_MAP = {
  'date'           => :time,
  'content-length' => :integer
}

def type_cast(header_name, header_value)
  case HEADERS_TYPE_MAP[header_name]
  when :time
    Time.parse(header_value)
  when :integer
    header_value.to_i
  else
    header_value
  end
end

def parse_headers(input)
  input.split("\n").inject({}) do |headers, line|
    parts = line.split(":")
    if parts.length > 1
      header_name = parts[0].downcase
      header_value = parts[1..-1].join(':').strip
      headers[header_name] = type_cast(header_name, header_value)
    end
    headers
  end
end

# Determine the full path to the example directory
examples_directory = File.expand_path('../../../exercises/parsing-http-headers/test/examples', __FILE__)

Dir.entries(examples_directory).each do |name|
  if name =~ /\.txt$/
    input = File.read(File.join(examples_directory, name))
    p parse_headers(input)
  end
end