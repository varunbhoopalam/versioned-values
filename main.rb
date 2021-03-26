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

# If update flag passed
# 4 actions to update (change value, re-order, add principle, remove principle)
# User is prompted that they can take any of those actions, when they type on in they go through one of the flows or end
# If a user hits end, they will be prompted to add release notes for the new version and shown the old and new value hierarchy
# Note: Could have a minor/major flag that's updated to major if any principle is removed or added

# change value
# User selects a value by it's index
# User inputs the new value
# User is brought back to initial screen with change made to values (old values are still in memory not updated)

# change order
# User selects a value by it's index
# User gives a new index for the selected value 
# OR user provides all values in order
# User is brought back to initial screen with change made to values (old values are still in memory not updated)

# add principle
# user prompted for principle
# user prompted for value
# user prompted for place in hierarchy
# update type flag changed to major
# User is brought back to initial screen with change made to values (old values are still in memory not updated)

# remove principle
# user prompted for value to remove
# update type flag changed to major
# User is brought back to initial screen with change made to values (old values are still in memory not updated)

# end update session
# user shown old hierarchy and new hierarchy with new version
# user asked to confirm changes
# user asked to provide release notes