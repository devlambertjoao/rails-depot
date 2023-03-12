class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
  end

  def add_to_cart
    @cart = find_cart
    product = Product.find(params[:id])
    Cart.add_product(@cart, product)

#     respond_to do |format|
#       format.html { render :show_cart }
#       format.json { render :show_cart, status: :ok }
#     end
  end

  def show_cart
    @cart_items = find_cart.cart_items
  end

  def clean_cart
    session[:cart_id] = nil
  end

  private

  def find_cart
    @cart = nil
    if session[:cart_id].nil?
      @cart = Cart.new
      @cart.save
      session[:cart_id] = @cart.id
    else
      @existent_cart = Cart.find_by(id: session[:cart_id])
      if @existent_cart.nil?
        @cart = Cart.new
        @cart.save
        session[:cart_id] = @cart.id
      else
        @cart = @existent_cart
      end
    end
    @cart
  end
end
