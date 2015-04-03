# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  layout 'default'

  before_filter :set_charset, :set_locale

  private

  def set_locale
    locale = params[:locale] || session[:locale] || DEFAULT_LOCALE

    begin
      Locale.set locale
      session[:locale] = locale
    rescue
      Locale.set DEFAULT_LOCALE
    end
  end

  def set_charset
    headers["Content-Type"] = "text/html; charset=utf-8"
    ActiveRecord::Base.connection.execute 'SET NAMES UTF8'
  end
  
  def check_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      create_cart
    end
  end
  
  def create_cart
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
