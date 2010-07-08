require 'rubygems'
require 'png'

def render_data(data, image_filename)
  canvas = PNG::Canvas.new(64, 65, PNG::Color::Black)
  center = 32
  
  data.each_with_index do |value, x|
    y = center + ((value / 100.0) * 31).round
    canvas.line(x, center, x, y, PNG::Color::Red)
  end
  
  canvas.line(0, center, 63, center, PNG::Color::White)
  PNG.new(canvas).save(image_filename)
end

def render_file(data_filename, image_filename)
  render_data(
    File.read(data_filename).split("\n").map { |line| line.to_i },
    image_filename
  )
end

render_file(
  File.expand_path('../../../exercises/drawing-graphs/test/examples/001-sinus.txt', __FILE__),
  File.expand_path('../../../public/images/drawing-graphs-solution.png', __FILE__)
)