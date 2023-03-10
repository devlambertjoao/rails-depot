class Cart < ApplicationRecord
  has_many :cart_items

  def add_product(product)
    @cart_items = [] if @cart_items.nil?
    current_item = @cart_items.find { |item| item.product == product }
    if current_item
      current_item.increment_quantity
    else
      @cart_item = CartItem.new
      @cart_item.save
      @cart_items << @cart_item

      save
    end
  end
end
