class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
  end

  def add_to_cart
    @cart = Cart.get_cart
    product = Product.find(params[:id])
    @cart.add_product(product)
    respond_to do |format|
      format.html { render :show_cart }
      format.json { render :show_cart, status: :ok }
    end
  end

  def show_cart
    @cart = find_cart
  end

  def clean_cart
    session[:cart] = Cart.new
  end

end
