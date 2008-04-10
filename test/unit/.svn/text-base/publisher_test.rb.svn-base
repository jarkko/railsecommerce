require File.dirname(__FILE__) + '/../test_helper'

class PublisherTest < Test::Unit::TestCase
  fixtures :publishers, :authors, :books

  def test_create_publisher
    publisher = Publisher.new
    publisher.name = 'Apress'
    assert publisher.save
    assert_not_nil Publisher.find_by_name('Apress')
  end

  def test_edit_publisher
    apress = Publisher.find_by_name("apress")
    assert_equal "apress", apress.name
    apress.name = "Apress.com" 
    assert apress.save
    assert_not_nil Publisher.find_by_name("Apress.com")
  end

  def test_delete_publisher
    apress = Publisher.find(1)
    assert apress.destroy
    assert_raise(ActiveRecord::RecordNotFound) {Publisher.find(1)}
  end

  def test_has_many_books_mapping
    apress = Publisher.find_by_name("apress")
    assert_equal 2, apress.books.size
    new_book = Book.new
    new_book.title = 'Pro Rails E-Commerce 3nd Edition'
    new_book.authors << Author.find(1)
    new_book.authors << Author.find(2)
    apress.books << new_book
    apress.reload
    assert_equal 3, apress.books.size
  end
end
