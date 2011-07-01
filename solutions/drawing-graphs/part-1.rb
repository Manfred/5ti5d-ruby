# Determine the full path to the data file
data_filename = File.expand_path('../../../exercises/drawing-graphs/examples/001-sinus.txt', __FILE__)

# Read the file from disk
input = File.read(data_filename)
data  = input.split("\n").map { |line| line.to_i }

# And print the parsed values to the terminal.
p data