require_relative '../../db/config.rb'

class ListItem < ActiveRecord::Base

  belongs_to :list  

  def complete!
    self.update_attributes(:completed_at => DateTime.now) 
  end

  def completed?
    !self.completed_at.nil?
  end
end
