require_relative '..models/list_item'
require_relative '../view/todo_view'
 
class TodoController
  attr_reader :id, :action, :task, :user_interface, :list_name, :tags, :list
 
  def initialize(args)
    @id             = args[:id]
    @action         = args[:action]
    @task           = args[:task]
    @list_name      = args[:list_name]
    @list           = List.where(:name => list_name).first
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
    {"id" => id, "list_name" => list_name, "list_id" => list.id, "tags" => tags, "task" => task, "completed_at" => nil}
  end

  def create_list
    List.create!(default_task_args)
  end

  def show_list
    Item.where(:list_id => list.id)
  end

  def delete_list
    user_interface.confirm_delete(list)
    list.destroy
    true
  end

  def add_task
    Item.create!(default_task_args)
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
