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
  elsif input_array.any? {|a| a == "-r"}
    Get.print_release_notes
  elsif input_array.any? {|a| a == "-l"}
    Get.print_version_list
  elsif input_array.any? {|a| a == "-v"}
    Get.print_version(input_array[1])
  else
    Get.print_latest
  end
end