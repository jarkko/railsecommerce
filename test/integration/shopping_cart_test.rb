require "#{File.dirname(__FILE__)}/../test_helper"

class ShoppingCartTest < ActionController::IntegrationTest
  fixtures :publishers, :authors, :books, :authors_books

  def test_filling_the_cart
     jill = enter_site(:jill)
     jill.adds_book_to_cart
     jill.removes_a_book
     jill.clears_the_cart
  end

  private

  module CartTestDSL
    attr_writer :name

    def adds_book_to_cart
      get "/catalog/"
      assert @cart_id = controller.session[:cart_id]
      @cart = Cart.find(@cart_id)
      
      post "/cart/add", :id => 1
      assert_response :redirect
      follow_redirect!
      assert_template "catalog/index"
    
      get "/catalog/"
      xml_http_request "/cart/add", :id => 5
      assert_template "cart/add_with_ajax"
      
      assert_equal Book.find([1,5]), @cart.books
    end
    
    def removes_a_book
      post "/cart/remove", :id => 1
      assert_response :redirect
      follow_redirect!
      assert_template "catalog/index"
      
      @cart.reload
      assert_equal Book.find([5]), @cart.books
      
      get "/catalog/"
      xml_http_request "/cart/remove", :id => 5
      assert_template "cart/remove_with_ajax"
      
      @cart.reload
      assert_equal [], @cart.books
    end
    
    def clears_the_cart
      post "/cart/add", :id => 1
      assert_equal 1, @cart.reload.books.size
      
      post "/cart/clear"
      assert_response :redirect
      follow_redirect!
      assert_template "catalog/index"
      assert @cart.reload.books.empty?
      
      post "/cart/add", :id => 1
      assert !@cart.reload.books.empty?
      
      xml_http_request "/cart/clear"
      assert_template "cart/clear_with_ajax"
      
    end
  end

  def enter_site(name)
    open_session do |session|
      session.extend(CartTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
