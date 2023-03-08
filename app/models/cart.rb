class Cart < ApplicationRecord
  has_many :cart_items

  def initialize
    self.cart_items = []
  end

  def add_product(product)
    current_item = @cart_items.find { |item| item.product == product }
    if current_item
      current_item.increment_quantity
    else
      cart_items << CartItem.new(product)
    end
  end

  def self.find
    @cart = Cart.find_by(:id, session[:cart_id])

    return unless @cart.nil?

    @cart = Cart.new
    session[:cart_id] = @cart.id
  end
end
