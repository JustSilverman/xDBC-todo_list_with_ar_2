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
    if check_list_name
      if self.respond_to?(action.to_sym)
        unless self.send(action.to_sym)
          user_interface.invalid_id
        end 
      else
        user_interface.non_action
      end
    else
      user_interface.invalid_list
    end
  end

  def default_task_args
    {"id" => id, "list_name" => list_name, "list_id" => list.id, "tags" => tags, "task" => task, "completed_at" => nil}
  end

  def create_list
    List.create!(default_task_args)
    user_interface.confirm_create(list_name)
    true
  end

  def show_list
    items = ListItem.where(:list_id => list.id)
    return false if items.nil?

    user_interface.display_list(items)
    true
  end

  def delete_list
    user_interface.confirm_delete_list(list)
    list.destroy
    true
  end

  def add_item
    item = ListItem.create!(default_task_args)
    user_interface.confirm_add(list_name, item)
    true
  end

  def complete_item
    item = ListItem.find(id)
    return false if item.nil?

    item.complete!
    user_interface.confirm_complete(item)
    true
  end

  def delete_item
    item = ListItem.find(id)
    return false if item.nil?

    user_interface.confirm_delete(list_name, item)
    item.destroy
    true
  end

  private

  def check_list_name
    List.where(:name => list_name).first
  end

end
