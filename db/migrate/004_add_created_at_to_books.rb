class AddCreatedAtToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :created_at, :datetime
    
    Book.find(:all).each do |book|
      book.created_at = Time.now
      book.save
    end
  end

  def self.down
    remove_column :books, :created_at
  end
end
