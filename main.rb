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
# If a user hits end, they will be prompted to add release notes for the new version and shown the old and new value hierarchy
# Note: Could have a none/minor/major flag that's updated to major if any principle is removed or added

module Update

  class UpdateSession
    
    @update_type = "none"
    
    def initialize(principles, previous_version)
      @principles_without_updates = principles
      @principles = principles
      @previous_version = previous_version
    end

    def value
      for hash in @principles
        puts("#{hash["index"]}. Principle: #{hash["principle"]} | Value: #{hash["value"]}\n")
      end
      puts("Type in the principle that you want to change the interpretation of (value). Or type back to go back.")
      valid_options = @principles.map { |p| p["principle"]}
      while input = Readline.readline("> ", true)
        break if input.strip.downcase == "back"
        break if @valid_options.any? { |option| option == input.strip.downcase }
        puts("I didn't recognize that.")
        puts("Type in the principle that you want to change the interpretation of (value). Or type back to go back.")
      end
      
      sanetized_input = input.strip.downcase
      
      if sanetized_input == "back"
        puts("Going back to update flow without making a value change")
      else 

        while new_value = Readline.readline("> ", true)
          break if new_value.length > 0
        end

        for hash in @principles 

          if hash["principle"] == sanetized_input
            hash["value"] = new_value
          end

          minor_change_made
        
        end 

    end


    # change order
# User selects a value by it's index
# User gives a new index for the selected value 
# OR user provides all values in order
# User is brought back to initial screen with change made to values (old values are still in memory not updated)

    def order

      minor_change_made
    end

        # add principle
# user prompted for principle
# user prompted for value
# user prompted for place in hierarchy
# update type flag changed to major
# User is brought back to initial screen with change made to values (old values are still in memory not updated)

    def add 
          
      major_change_made
    end

    # remove principle
# user prompted for value to remove
# update type flag changed to major
# User is brought back to initial screen with change made to values (old values are still in memory not updated)

    def remove 

      major_change_made
    end

# end update session
# user shown old hierarchy and new hierarchy with new version
# user asked to confirm changes
# user asked to provide release notes

    def finish 
    
    end 

    def minor_change_made
      if @update_type != "major"
        @update_type = "minor"
      end
    end 

    def major_change_made
      @update_type = "major"
    end 
  end

  def self.update_flow
    puts("\nWelcome to the update flow. Here you can make changes to your value hierarchy and publish a new version!")
    Get.get_latest
    foo_update
  end

  def self.foo_update(session)
    
    puts("\nvalue - update your interpretation of a principle")
    puts("order - change the order of your value hierarchy")
    puts("add - add a principle + value to your hierarchy")
    puts("remove - remove a principle + value from your hierarchy")
    puts("Select an option by typing one of the following options")
    options = ["value", "order", "add", "remove", "finish"]
    puts(options.join(" | "))

    while input = Readline.readline("> ", true)
      break if options.any? { |option| option == input.strip.downcase }
    end

    case input.strip.downcase
    when "value"
      session.value
      foo_update(session)
    when "order"
      session.order
      foo_update(session)
    when "add"
      session.add
      foo_update(session)
    when "remove"
      session.remove
      foo_update(session)
    when "finish"
      session.finish
    else
      "You gave me #{input} -- I have no idea what to do with that."  
      foo_update(session)
    
    
  end

end