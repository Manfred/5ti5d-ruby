require 'rubygems'
require 'png'

# Determine the full path to the images directory so the result ends up in the exercises document.
graph_filename = File.expand_path('../../../public/images/drawing-graphs-line.png', __FILE__)

# Create a PNG canvas with a black background
canvas = PNG::Canvas.new(64, 65, PNG::Color::Black)

# Draw a white line across the image in the center
canvas.line(0, 32, 63, 32, PNG::Color::White)

# Write the file to disk
PNG.new(canvas).save(graph_filename)