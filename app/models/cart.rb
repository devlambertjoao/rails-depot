class Cart < ApplicationRecord
  has_many :cart_items

  def self.add_product(cart, product)
    current_item = cart.cart_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity = current_item.quantity + 1
      current_item.save
    else
      @cart_item = CartItem.new
      @cart_item.cart_id = cart.id
      @cart_item.product_id = product.id
      @cart_item.quantity = 1
      @cart_item.save
    end
  end
end
