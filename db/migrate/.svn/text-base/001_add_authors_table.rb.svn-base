class AddAuthorsTable < ActiveRecord::Migration
  def self.up
    create_table :authors do |table|
      table.column :first_name, :string
      table.column :last_name, :string
    end
  end

  def self.down
    drop_table :authors
  end
end