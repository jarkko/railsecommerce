class ForumPost < ActiveRecord::Base
  acts_as_threaded
  
  validates_length_of :name, :within => 2..50
  validates_length_of :subject, :within => 5..255
  validates_length_of :body, :within => 5..5000
end
