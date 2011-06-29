# encoding: utf-8

# Input as defined in the exercise
input = "Date: Sun, 25 Apr 2010 12:17:38 GMT
Server: Apache/2.2.14 (Unix)
Content-Length: 44
Content-Type: text/html"

# Initialize a new Hash
headers = {}

# Split the input by its newlines and loop through them
input.split("\n").each do |line|
  
  # Split a line by the semicolon
  parts = line.split(":", 2)
  
  # Downcase the header name so they're always uniform
  header_name = parts[0].downcase
  
  # The value can include semicolons like in the date
  # value, therefore we need to re-join the parts.
  # We also strip off all the whitespace.
  header_value = parts[1].strip
  
  # Now assign them to the header hash.
  headers[header_name] = header_value
end

# Pretty print the result to the terminal
require 'pp'
pp headers