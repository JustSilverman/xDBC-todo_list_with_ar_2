require_relative '../app/controllers/todo_controller.rb'
 
class ToDo
  def self.run(commands)
    list_name = commands.first
    action     = commands[1]
    args = { :list_name => list_name, :action => action.to_s }
 
    if action == "add_item"
      args.merge!(:task => commands[2..-1].join(" "))
    elsif action == "delete_item" || action == "complete_item"
      args.merge!(:id => commands[2])
    end
 
    TodoController.new(args)
  end
end
 
commands = ARGV
ToDo.run(commands)
