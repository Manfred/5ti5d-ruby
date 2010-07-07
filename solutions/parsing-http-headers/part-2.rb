# encoding: utf-8

# Define a method so we can seperate this part of the code from the main
# loop at the end of the file.
def parse_headers(input)
  
  # Instead of each we now use inject to we don't have to initialize the
  # headers hash from outside the loop.
  input.split("\n").inject({}) do |headers, line|
    parts = line.split(":")
    
    # In the files the headers start with a status line, we need to
    # ignore it so we only use lines which have at least one semicolon.
    if parts.length > 1
      header_name = parts[0].downcase
      header_value = parts[1..-1].join(':').strip
      headers[header_name] = header_value
    end
    headers
  end
end

# Determine the full path to the examples directory
examples_directory = File.expand_path('../../../exercises/parsing-http-headers/test/examples', __FILE__)

# Loop over all the entries in the examples directory
Dir.entries(examples_directory).each do |name|
  
  # Directory entries also include the . and .. special directories on
  # UNIX so we need to ignore those.
  if name =~ /\.txt$/
    
    # Read the file from disk
    input = File.read(File.join(examples_directory, name))
    
    # And print the parsed headers to the terminal.
    puts name
    p parse_headers(input)
  end
end