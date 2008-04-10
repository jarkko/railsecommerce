class AddBooksTableAndMapToAuthors < ActiveRecord::Migration
  def self.up
    create_table :books do |table|
      table.column :title, :string, :limit => 255, :null => false
      table.column :publisher_id, :integer, :null => false
      table.column :price, :float, :default => 0.0
      table.column :page_count, :integer, default => 0
    end

    create_table :authors_books do |table|
      table.column :author_id, :integer, :null => false
      table.column :book_id, :integer, :null => false
    end

    say_with_time 'Adding foreign keys' do
      # Add foreign key reference to authors_books table
      execute 'ALTER TABLE authors_books ADD CONSTRAINT fk_bk_authors FOREIGN KEY ( author_id ) REFERENCES authors( id ) ON DELETE CASCADE ON UPDATE CASCADE'
      execute 'ALTER TABLE authors_books ADD CONSTRAINT fk_bk_books FOREIGN KEY ( book_id ) REFERENCES books( id ) ON DELETE CASCADE ON UPDATE CASCADE'

      # Add foreign key reference to publishers table
      execute 'ALTER TABLE books ADD CONSTRAINT fk_books_publishers FOREIGN KEY ( publisher_id ) REFERENCES publishers( id ) ON DELETE CASCADE ON UPDATE CASCADE'
    end
  end

  def self.down
    drop_table :authors_books
    drop_table :books
  end
end
