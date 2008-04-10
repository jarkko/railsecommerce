class AddForumPostsTable < ActiveRecord::Migration
  def self.up
    create_table :forum_posts do |table|
      table.column :name, :string, :limit => 50, :null => false
      table.column :subject, :string, :limit => 255, :null => false
      table.column :body, :text
      
      table.column "root_id", :integer, :null => false, :default => 0
      table.column "parent_id", :integer, :null => false, :default => 0
      table.column "lft", :integer, :null => false, :default => 0
      table.column "rgt", :integer, :null => false, :default => 0
      table.column "depth", :integer, :null => false, :default => 0

      table.column :created_at, :timestamp, :null => false
      table.column :updated_at, :timestamp, :null => false
    end
  end

  def self.down
    drop_table :forum_posts
  end
end
