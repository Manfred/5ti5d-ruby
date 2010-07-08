require 'rubygems'
require 'png'

public_directory = File.expand_path('../../../public', __FILE__)

canvas = PNG::Canvas.new(64, 65, PNG::Color::Black)
canvas.line(0, 32, 63, 32, PNG::Color::White)
PNG.new(canvas).save(File.join(public_directory, 'images/drawing-graphs-line.png'))