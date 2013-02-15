require_relative '../config'

class CreateListsAndListId < ActiveRecord::Migration
  
  def change
    create_table :lists do |l|
      l.string     :name
      l.timestamps
    end

    add_column :list_items, :list_id, :integer
  end
end
