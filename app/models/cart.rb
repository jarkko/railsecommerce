class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :books, :through => :cart_items
  
  def add(book_id)
    items = cart_items.find_all_by_book_id(book_id)
    book = Book.find(book_id)
    
    if items.size < 1
      ci = cart_items.create(:book_id => book_id,
                             :amount => 1,
                             :price => book.price)
    else
      ci = items.first
      ci.update_attribute(:amount, ci.amount + 1)
    end
    ci
  end
  
  def remove(book_id)
    ci = cart_items.find_by_book_id(book_id)
    
    if ci.amount > 1
      ci.update_attribute(:amount, ci.amount - 1)
      return ci
    else
      CartItem.destroy(ci.id)
      return ci
    end
  end
  
  def total
    cart_items.inject(0) {|sum, n| n.price * n.amount + sum}
  end
end