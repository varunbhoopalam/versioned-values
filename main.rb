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
    versions = Get.get_all_descending
    for version in versions
      puts("---------------")
      version.get_version.print_version
      puts(version.get_release_notes)
    end
  else
    latest = Get.get_latest
    latest.get_version.print_version
    latest.get_values.print
  end
end