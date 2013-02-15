require_relative '../app/controllers/todo_controller.rb'
 
class ToDo
  def self.run(commands)
    action = commands.first
    args = { :action => action.to_s }
 
    if action == "add"
      args.merge!(:task => commands[1..-1].join(" "))
    elsif action == "delete" || action == "complete"
      args.merge!(:id => commands[1])
    end
 
    TodoController.new(args)
  end
end
 
commands = ARGV
ToDo.run(commands)
