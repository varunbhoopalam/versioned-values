#!/usr/bin/ruby
require 'readline'
while input = Readline.readline("> ", true)
  break if input == "exit"
  puts(input)
end
