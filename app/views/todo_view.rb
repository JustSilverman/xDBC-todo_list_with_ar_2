class TodoView
  COMPLETION = {true => "[X]", false => "[ ]"}
 
  def display_list(list)
    list.each do |item|
      puts "#{item.id}.".ljust(4) + " #{COMPLETION[item.completed?]} #{item.task}"
    end
  end
 
  def confirm_add(item)
    puts "Appended #{item.task} to your TODO list..."
  end
 
  def confirm_delete(item)
    puts "Deleted #{item.task} from your TODO list..."
  end
 
  def confirm_complete(item)
    puts "#{item.task} has been marked as complete!"
  end
 
  def non_action
    puts "Command not recognized."
  end
 
  def invalid_id
    puts "Invalid id."
  end
end
