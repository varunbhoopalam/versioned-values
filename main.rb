#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'init'
require 'get'

if __FILE__ == $0
  if not Dir.exists?(".values/1-0")
    Init.init
  else
    Get.get_latest
  end
end