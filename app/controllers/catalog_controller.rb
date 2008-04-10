class CatalogController < ApplicationController
  before_filter :check_cart, :except => [:rss]
  before_filter :set_return_to, :except => [:rss]

  def index
    @page_title = "Book List"
    @book_pages, @books = paginate :books, 
                            :per_page => 10,
                            :include => [:authors, :publisher],
                            :order => "books.id desc"
  end

  def show
    @book = Book.find(params[:id])
    @page_title = @book.title
  end

  def search
    @page_title = "Search"
    if params[:commit] == "Search" || params[:q]
      @books = Book.find_by_contents(params[:q].to_s.upcase)
      unless @books.size > 0
        @notice = "No books found matching your criteria"
      end
    end
  end

  def latest
    @page_title = "Latest Books"
    @books = Book.latest
  end
  
  def rss
    latest
    render :layout => false
  end
  
  private
  
  def set_return_to
    session[:return_to] = request.request_uri
  end
  
end
