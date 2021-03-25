#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'init'

if __FILE__ == $0
  if not Dir.exists?(".values/1-0")
    Init.init
  else
    puts("To Do: Pretty Print Latest Value Hierarchy")
  end
end