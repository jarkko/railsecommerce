require "#{File.dirname(__FILE__)}/../test_helper"

class BookTest < ActionController::IntegrationTest
  fixtures :authors, :publishers, :books, :authors_books

  def test_book_admin_interface
    new_session do |admin|
      title = "Great balls of fire!"
      admin.add_book title
      admin.view_book title
      admin.list_books title
      new_title = "Elvis Sandwich Recipes"
      admin.upload_cover title, 'image.gif'
      admin.edit_book title, new_title
      admin.delete_book new_title
    end
  end

  private

  module BookTestDSL
    def add_book(title)
      author = Author.find(:all).first
      publisher = Publisher.find(:all).first

      get "/admin/book/new"
      assert_response :success
      assert_template "admin/book/new"

      assert_tag :tag => 'option', :attributes => { :value => author.id }
      assert_tag :tag => 'input', :attributes => { :id => 'book[author_ids][]', :value => author.id}

      post "/admin/book/create", "book[title]" => title, 
        "book[author_ids][]" => author.id, 
        "book[publisher_id]" => publisher.id
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template "admin/book/list"
      assert_not_nil Regexp.new(Regexp.escape(title)).match(@response.body)
    end
    
    def view_book(title)
      book = Book.find_by_title(title)
      assert_not_nil book
      
      get "/admin/book/show/#{book.id}"
      assert_response :success
      assert_template "admin/book/show"
      assert_not_nil Regexp.new(Regexp.escape(book.title)).match(@response.body)
    end

    def list_books(title)
      book = Book.find_by_title(title)
      assert_not_nil book

      get "/admin/book/list"
      assert_response :success
      assert_template "admin/book/list"
      assert_not_nil Regexp.new(Regexp.escape(book.title)).match(@response.body)
      assert_not_nil /Listing books/.match(@response.body)
    end

    def delete_book(title)
      book = Book.find_by_title(title)
      post "/admin/book/destroy/#{book.id}"
      follow_redirect!
      assert_response :success
      assert_template "admin/book/list"
      assert_nil Book.find_by_title(title) 
    end

    def edit_book(title, new_title)
      book = Book.find_by_title(title)

      get "/admin/book/edit/#{book.id}"
      assert_response :success

      post "/admin/book/update/#{book.id}", "book[title]" => new_title
      follow_redirect!
      assert_response :success
      assert_template "admin/book/show"
      assert_not_nil Regexp.new(Regexp.escape(new_title)).match(@response.body)
    end
    
    def upload_cover(title, image)
      book = Book.find_by_title(title)

      post "/admin/book/upload_cover", :cover => fixture_file_upload(image, 'image/gif')
      assert_response :success
    end
  end

  def new_session
    open_session do |session|
      session.extend(BookTestDSL)
      yield session if block_given?
    end
  end
  
end
