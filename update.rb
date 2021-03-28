#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'writer'

class UpdateSession
      
  def initialize(versioned_values)
    @values = versioned_values.get_values
    @version = versioned_values.get_version
    @updated = false
  end

  def change_value
    @values.print
    puts("Type in the principle that you want to change the interpretation of. Or type back to go back.")
    while input = Readline.readline("> ", true)
      input = input.strip.downcase
      break if input == "back"
      break if @values.get_principles.any? { |option| option.strip.downcase == input }
      puts("I didn't recognize that.")
      puts("Type in the principle that you want to change the interpretation of. Or type back to go back.")
    end    
    if input == "back"
      puts("Going back to update flow without making a value change")
    else 
      puts("Type in your new interpretation of your principle: #{input}")
      while new_value = Readline.readline("> ", true) 
        break if new_value.length > 0 
      end
      @values.update_value(input, new_value)
      @updated = true
    end
  end

  def finish 
    if @updated == false
      puts("No updates! Signing off")
    else 
      puts("Here is your new hierarchy")
      @values.print
      puts("Can you give some notes on what has changed and why?")
      while release_notes = Readline.readline("> ", true) 
        break if release_notes.length > 0 
      end
      Writer.write(@values.encode, @version.next_minor_version.get_version, release_notes)
    end
  end
end

module Update
  def self.update_flow
    puts("\nWelcome to the update flow. Here you can make changes to your value hierarchy and publish a new version!")
    puts("Coming soon you'll be able to re-order, add, and remove principles!")

    session = UpdateSession.new(Get.get_latest)
    still_in_session = true
    
    while still_in_session
      puts("\nvalue - update your interpretation of a principle")
      puts("Select an option by typing one of the following options")
      options = ["value", "finish"]
      puts(options.join(" | "))
  
      while input = Readline.readline("> ", true) 
        break if options.any? { |option| option == input.strip.downcase } 
      end
  
      case input.strip.downcase
      when "value"
        session.change_value
      when "finish"
        session.finish
        still_in_session = false
      else
        "You gave me #{input} -- I have no idea what to do with that :)"
      end
    end
  end
end