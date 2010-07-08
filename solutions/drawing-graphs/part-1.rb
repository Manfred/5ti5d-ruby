# Determine the full path to the examples directory
examples_directory = File.expand_path('../../../exercises/drawing-graphs/test/examples', __FILE__)

# Loop over all the entries in the examples directory
Dir.entries(examples_directory).each do |name|
  
  # Directory entries also include the . and .. special directories on
  # UNIX so we need to ignore those.
  if name =~ /\.txt$/
    
    # Read the file from disk
    input = File.read(File.join(examples_directory, name))
    data = input.split("\n").map { |line| line.to_i }
    
    # And print the parsed headers to the terminal.
    puts name
    p data
  end
end