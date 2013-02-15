require_relative '../config'

class CreateListItems < ActiveRecord::Migration
  
  def change
    create_table :list_items do |l|
      l.datetime :completed_at
      l.text     :task
      l.timestamps
    end
  end
end
