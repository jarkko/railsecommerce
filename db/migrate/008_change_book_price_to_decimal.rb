class ChangeBookPriceToDecimal < ActiveRecord::Migration
  def self.up
    change_column :books, :price, :decimal, :precision => 10, :scale => 2
  end

  def self.down
    change_column :books, :price, :float
  end
end
