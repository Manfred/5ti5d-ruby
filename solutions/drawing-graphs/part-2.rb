require 'rubygems'
require 'chunky_png'

# Determine the full path to the images directory so the result ends up in the exercises document.
graph_filename = File.expand_path('../../../public/images/drawing-graphs-line.png', __FILE__)

# Create a PNG image with a black background
image = ChunkyPNG::Image.new(64, 65, ChunkyPNG::Color.rgba(0, 0, 0, 255))

# Draw a white line across the image in the center
image.line(0, 32, 63, 32, ChunkyPNG::Color.rgba(255, 255, 255, 255))

# Write the file to disk
image.save(graph_filename)