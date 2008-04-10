require File.dirname(__FILE__) + '/../test_helper'

class BookTest < Test::Unit::TestCase
  fixtures :publishers, :authors, :books, :authors_books

  def test_create_book_without_specifying_publisher_and_authors
    book = Book.new
    book.title = %(What's your name?)
    assert !book.save
    assert_equal 2, book.errors.size
    assert book.errors.on(:authors)
    assert book.errors.on(:publisher)
  end

  def test_has_and_belongs_to_many_authors_mapping
    book = Book.new
    book.title = 'Pro Rails E-Commerce 4nd Edition'
    book.authors << Author.find(1)
    book.authors << Author.find(2)
    book.publisher = Publisher.find(1)
    assert book.save
    assert_equal 2, Book.find_by_title("Pro Rails E-Commerce 4nd Edition").authors.size
  end
  
  def test_ferret
    Book.rebuild_index
  
    assert_equal 1, Book.find_by_contents("Pride Prejudice").size
  
    assert_difference Book, :count do
      book = Book.new
      book.title = 'The Success of Open Source'
      book.authors << Author.create(:first_name => "Steven", :last_name => "Weber")
      book.publisher = Publisher.find(1)
      assert book.save
  
      assert_equal 1, Book.find_by_contents("Open Source").size
      assert_equal 1, Book.find_by_contents("Steven Weber").size
    end
  end

end