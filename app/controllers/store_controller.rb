class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
  end

  def add_to_cart
    @cart = Cart.find_by(id: session[:cart_id])

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
    session[:cart_id] = nil
  end

  def find_cart
    @cart = Cart.find_by(id: session[:cart_id])

    return unless @cart.nil?

    @cart = Cart.new
    @cart.save
    session[:cart_id] = @cart.id

    @cart
  end
end
