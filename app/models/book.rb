class Book < ActiveRecord::Base
  #translates :title
  has_and_belongs_to_many :authors
  belongs_to :publisher
  has_many :cart_items
  has_many :carts, :through => :cart_items 
  
  #acts_as_ferret :fields => [:title, :authornames]

  
  validates_presence_of :publisher, :authors

  def cover=(uploaded_file)  
    puts uploaded_file.inspect
    @uploaded_file = uploaded_file
    write_attribute("content_type", @uploaded_file.content_type)
  end
  
  def authornames
    self.authors.map{|a| "#{a.first_name} #{a.last_name}"}.join(", ") rescue ""
  end

  def self.latest
    find :all, :limit => 10, :order => "books.id desc", :include => [:authors, :publisher]
  end
end
