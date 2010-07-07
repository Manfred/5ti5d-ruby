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
  parts = line.split(":")
  
  # Use the downcased header name as the key and set its
  # value. Strip the whitespace off the value.
  headers[parts[0].downcase] = parts[1..-1].join(":").strip
end

# Print the result to the terminal
p headers