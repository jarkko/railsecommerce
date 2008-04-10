class AddPublishersTable < ActiveRecord::Migration
  def self.up
    create_table :publishers do |table|
      table.column :name, :string, :limit => 255, :null => false
    end
  end

  def self.down
    drop_table :publishers
  end
end
