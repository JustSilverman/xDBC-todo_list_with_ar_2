require_relative '../app/controllers/todo_controller.rb'
 
class ToDo
  def self.run(commands)
    table_name = commands.first
    action     = commands[1]
    args = { :table_name => table_name, :action => action.to_s }
 
    if action == "add_task"
      args.merge!(:task => commands[2..-1].join(" "))
    elsif action == "delete_task" || action == "complete_task"
      args.merge!(:id => commands[2])
    end
 
    TodoController.new(args)
  end
end
 
commands = ARGV
ToDo.run(commands)
