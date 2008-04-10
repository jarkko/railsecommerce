class Author < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  has_and_belongs_to_many :books
  
  def name
    "#{first_name} #{last_name}"
  end
end
