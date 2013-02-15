require_relative '../../db/config.rb'

class List < ActiveRecord::Base

  has_many :list_items
  
end
