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
    versions = Get.get_all
    for version in versions
      version.get_version.print_version
      puts(version.get_release_notes)
      puts("---------------")
    end
  elsif input_array.any? {|a| a == "-l"}
    versions = Get.get_version_list
    for version in versions
      puts(version)
    end
  elsif input_array.any? {|a| a == "-v"}
    Get.print_version(input_array[1])
  else
    latest = Get.get_latest
    latest.get_version.print_version
    latest.get_values.print
  end
end