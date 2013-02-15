require_relative '..models/list_item'
require_relative '../view/todo_view'
 
class TodoController
  attr_reader :id, :action, :task, :user_interface, :list_name, :tags
 
  def initialize(args)
    @id             = args[:id]
    @action         = args[:action]
    @task           = args[:task]
    @list_name      = args[:list_name]
    @tags           = args[:tags]
    @user_interface = TodoView.new
    execute!
  end
 
  def execute!
    if self.respond_to?(action.to_sym)
      unless self.send(action.to_sym)
        user_interface.invalid_id
      end 
    else
      user_interface.non_action
    end
  end

  def default_task_args
    {"id" => id, "list_name" => list_name, "tags" => tags, "task" => task, "completed_at" => nil}
  end

  def create_list
  end

  def show_list
  end

  def delete_list
  end

  def add_task
    list = List.where(:name => list_name).first
    Task.create!(:list_id => list.id )
  end

  def complete_task
  end

  def delete_task
  end
 
  def add
    item = ListItem.create!(default_task_args)
    user_interface.confirm_add(item)
    true
  end
 
  def list
    user_interface.display_list(ListItem.all)
  end
 
  def delete
    item = ListItem.all[id-1]
    return false if item.nil?
 
    user_interface.confirm_delete(item)
    item.destroy
    true
  end
 
  def complete
    item = ListItem.all[id-1]
    return false if item.nil?
 
    item.complete!
    user_interface.confirm_complete(item)
    true
  end
end
