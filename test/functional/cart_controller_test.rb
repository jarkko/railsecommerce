require File.dirname(__FILE__) + '/../test_helper'
require 'cart_controller'

# Re-raise errors caught by the controller.
class CartController; def rescue_action(e) raise e end; end

class CartControllerTest < Test::Unit::TestCase
  def setup
    @controller = CartController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_adding
    assert_difference(CartItem, :count) do
      post :add, :id => 4
    end
    
    assert_response :redirect
    assert_redirected_to :controller => "catalog"
    assert_equal 1, Cart.find(@request.session[:cart_id]).cart_items.size
  end
  
  def test_adding_with_xhr
    assert_difference(CartItem, :count) do
      xhr :post, :add, :id => 5
    end
    assert_response :success
    assert_equal 1, Cart.find(@request.session[:cart_id]).cart_items.size
  end
  
  def test_removing
    post :add, :id => 4
    assert_equal [Book.find(4)], Cart.find(@request.session[:cart_id]).books
    
    post :remove, :id => 4
    assert_equal [], Cart.find(@request.session[:cart_id]).books
  end
  
  def test_removing_with_xhr
    post :add, :id => 4
    assert_equal [Book.find(4)], Cart.find(@request.session[:cart_id]).books
    
    xhr :post, :remove, :id => 4
    assert_equal [], Cart.find(@request.session[:cart_id]).books
  end
  
  def test_clearing
    post :add, :id => 4
    assert_equal [Book.find(4)], Cart.find(@request.session[:cart_id]).books
    
    post :clear
    assert_response :redirect
    assert_redirected_to :controller => "catalog"
    assert_equal [], Cart.find(@request.session[:cart_id]).books
  end
  
  def test_clearing_with_xhr
    post :add, :id => 4
    assert_equal [Book.find(4)], Cart.find(@request.session[:cart_id]).books

    xhr :post, :clear
    assert_response :success
    assert_equal 0, Cart.find(@request.session[:cart_id]).cart_items.size
  end
end