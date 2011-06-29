# encoding: utf-8

require 'pp'

# Define a method so we can seperate this part of the code from the main
# loop at the end of the file.
def parse_headers(input)
  
  # Instead of each we now use inject to we don't have to initialize the
  # headers hash from outside the loop.
  input.split("\n").inject({}) do |headers, line|
    # You can assign multiple variables at once when the method returns an array
    header_name, header_value = line.split(":", 2)
    
    # In the files the headers start with a status line, we need to
    # ignore it so we only use lines which have at least one semicolon.
    unless header_value.nil?
      headers[header_name.downcase] = header_value.strip
    end
    
    headers
  end
end

# Determine the full path to the examples directory
examples_directory = File.expand_path('../../../exercises/parsing-http-headers/examples', __FILE__)

# Loop over all the entries in the examples directory
Dir.glob(File.join(examples_directory, '*.txt')).each do |filename|
  # Read the file from disk
  input = File.read(filename)
  
  # And print the parsed headers to the terminal
  puts
  puts File.basename(filename)
  pp parse_headers(input)
end