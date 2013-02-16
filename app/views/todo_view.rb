require_relative "../models/list_item"

class TodoView
  COMPLETION = {true => "[X]", false => "[ ]"}
 
  def display_list(items)
    puts "No items in list." if items.empty?
    items.each_with_index do |item, index|
      puts "#{index + 1}.".ljust(4) + " #{COMPLETION[item.completed?]} #{item.task}"
    end
  end
 
  def confirm_add(list, item)
    puts "Appended #{item.task} to your #{list} list..."
  end

  def confirm_complete(item)
    puts "#{item.task} has been marked as complete!"
  end
 
  def confirm_delete(list, item)
    puts "Deleted #{item.task} from your #{list} list..."
  end

  def confirm_create(name)
    puts "Created #{name} list."
  end

  def confirm_delete_list(list)
    puts "Deleted #{list.name} from your lists..."
  end
 
  def non_action
    puts "Command not recognized."
  end

  def invalid_list
    puts "Invalid list."
  end
 
  def invalid_id
    puts "Invalid id."
  end
end
