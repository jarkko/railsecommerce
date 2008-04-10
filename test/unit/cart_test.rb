require File.dirname(__FILE__) + '/../test_helper'

class CartTest < Test::Unit::TestCase
  fixtures :carts, :books

  # Replace this with your real tests.
  def test_adding_and_removing
    c = Cart.create
    assert_difference(c.cart_items, :size, 3) do
      [1, 3, 4].each do |i|
        assert c.add(i)
      end
    end
    
    assert_equal Book.find([1,3,4]), c.books
    
    [1, 3, 4].each do |i|
      assert c.remove(i)
    end
    assert_equal [], c.reload.cart_items
  end

end
