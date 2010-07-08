require 'rubygems'
require 'png'

# Define a method that renders integer data to a file
def render_data(data, image_filename)
  canvas = PNG::Canvas.new(64, 65, PNG::Color::Black)
  
  # The y-coordinate of the center is 32
  center = 32
  
  # Loop over all the data together with the index of the data
  # we use the the index as the x-coordinate
  data.each_with_index do |value, x|
    
    # Scale the values so they fit in our image
    y = center + ((value / 100.0) * 31).round
    
    # Draw a line from the center to the value we calculated
    canvas.line(x, center, x, y, PNG::Color::Red)
  end
  
  # Draw a white line across the center
  canvas.line(0, center, 63, center, PNG::Color::White)
  
  # Write the PNG to disk
  PNG.new(canvas).save(image_filename)
end

# Define a method that renders data from a filename to a file
def render_file(data_filename, image_filename)
  render_data(
    File.read(data_filename).split("\n").map { |line| line.to_i },
    image_filename
  )
end

# Call the render method with the data filename and a filename in the public directory so
# the image shows up in the exercises.
render_file(
  File.expand_path('../../../exercises/drawing-graphs/test/examples/001-sinus.txt', __FILE__),
  File.expand_path('../../../public/images/drawing-graphs-solution.png', __FILE__)
)