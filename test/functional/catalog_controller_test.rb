require File.dirname(__FILE__) + '/../test_helper'
require 'catalog_controller'

# Re-raise errors caught by the controller.
class CatalogController; def rescue_action(e) raise e end; end

class CatalogControllerTest < Test::Unit::TestCase
  def setup
    @controller = CatalogController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    get :index
  
    assert_response :success
    assert_template "catalog/index"
    assert_tag      :tag => "dl", :attributes => 
                      { :id => "books" },
                    :children => 
                      { :count => 10, :only => 
                        {:tag => "dt"}}
    assert_tag :tag => "dt", :content => "The Idiot"
    check_book_links
    
    get :index, :page => 2
    assert_response :success
    assert_template "catalog/index"
    assert_equal    Book.find_by_title("Pro Rails E-Commerce"),
                    assigns(:books).last
    check_book_links
    
    @book = Book.find_by_title("Pride and Prejudice")
    get :show, :id => @book.id
    assert_response :success
    assert_template "catalog/show"

    assert_tag      :tag => "h1",
                    :content => @book.title
    assert_tag      :tag => "h2",
                    :content => "by #{@book.authors.map{|a| a.name}}"
  end
  
  private
  def check_book_links
    for book in assigns(:books)
      assert_tag    :tag => "a", :attributes => 
                      { :href => "/catalog/show/#{book.id}"}
    end
  end
end
