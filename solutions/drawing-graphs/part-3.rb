require 'rubygems'
require 'chunky_png'

# Define a method that renders integer data to a file
def render_data(data, image_filename)
  white = ChunkyPNG::Color.rgba(*[255]*4)
  red = ChunkyPNG::Color.rgba(255, 0, 0, 255)
  
  image = ChunkyPNG::Image.new(64, 65, ChunkyPNG::Color.rgba(0, 0, 0, 255))
  
  # The y-coordinate of the center is 32
  center = 32
  
  # Loop over all the data. We use the index of the values
  # as the x-coordinate.
  data.each_with_index do |value, x|
    
    # Scale the values so they fit in our image
    y = center + ((value / 100.0) * 31).round
    
    # Draw a line from the center to the value we calculated
    image.line(x, center, x, y, red)
  end
  
  # Draw a white line across the center
  image.line(0, center, 63, center, white)
  
  # Write the PNG to disk
  image.save(image_filename)
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
  File.expand_path('../../../exercises/drawing-graphs/examples/001-sinus.txt', __FILE__),
  File.expand_path('../../../public/images/drawing-graphs-solution.png', __FILE__)
)