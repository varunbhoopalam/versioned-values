#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'init'
require 'get'
require 'update'

if __FILE__ == $0
  input_array = ARGV
  if not Dir.exists?(".values/1-0")
    Init.init
  elsif input_array.any? {|a| a == "-u"}
    Update.update_flow
  else
    latest = Get.get_latest
    latest.get_version.print_version
    latest.get_values.print
  end
end