require 'time'

class Response
  HEADERS_TYPE_MAP = {
    'date'           => :time,
    'content-length' => :integer
  }
  
  attr_accessor :headers
  
  def initialize
    @headers = {}
  end
  
  def parse(input)
    input.split("\n").inject({}) do |headers, line|
      header_name, header_value = line.split(":", 2)
      if header_name.start_with?('HTTP') and header_value.nil?
        @status = self.class.parse_status_line(header_name)
      else
        header_name = header_name.downcase
        # Instead of directory assigning the value we now first type-cast it
        @headers[header_name] = self.class.type_cast_header(header_name, header_value)
      end
      headers
    end
  end
  
  def status_code
    @status.first
  end
  
  def status_message
    @status.last
  end
  
  def self.parse(input)
    response = new
    response.parse(input)
    response
  end
  
  def self.type_cast_header(header_name, header_value)
    case HEADERS_TYPE_MAP[header_name]
    when :time
      Time.parse(header_value)
    when :integer
      header_value.to_i
    when nil
      header_value.strip
    else
      # Raise an argument error when we defined a type in the type map which
      # we can't handle.
      raise ArgumentError, "Unknown header type `#{header_type.inspect}'"
    end
  end
  
  def self.parse_status_line(status_line)
    if match = /^HTTP\/1\.1\s+(\d+)\s+(.*)$/.match(status_line.strip)
      [match[1].to_i, match[2]]
    end
  end
end

# When ran as a standalone file, thus not included
if __FILE__ == $0
  examples_directory = File.expand_path('../../../exercises/parsing-http-headers/examples', __FILE__)
  Dir.glob(File.join(examples_directory, '*.txt')).each do |filename|
    response = Response.parse(File.read(filename))
    p response
  end
end