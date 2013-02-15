require 'rake'
require 'rspec/core/rake_task'
require 'faker'
require_relative 'db/config'
require_relative 'app/models/list_item'
require_relative 'app/models/list'

desc "create the database"
task "db:create" do
  touch 'db/todo_list.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/todo_list.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc "populate the test database with sample data"
task "db:populate" do
  10.times do
    List.create(:name  => "#{Faker::Name.name}'s list")
  end

  all_lists = List.all
  100.times do 
    new_list_item = ListItem.create(:task => Faker::Company.bs,
                                    :completed_at => nil)
    list = all_lists.sample
    list.list_items << new_list_item
    new_list_item.save
  end
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

# desc "Run the specs"
# RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
