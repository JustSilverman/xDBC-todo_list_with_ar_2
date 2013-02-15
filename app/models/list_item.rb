class ListItem < ActiveRecord::Base

  def complete!
    self.update_attributes(:completed_at => DateTime.now) 
  end

  def completed?
    !self.completed_at.nil?
  end
end
