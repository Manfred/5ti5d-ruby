# encoding: utf-8

def parse_headers(input)
  input.split("\n").inject({}) do |headers, line|
    parts = line.split(":")
    if parts.length > 1
      header_name = parts[0].downcase
      header_value = parts[1..-1].join(':').strip
      headers[header_name] = header_value
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