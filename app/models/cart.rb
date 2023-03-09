class Cart < ApplicationRecord
  has_many :cart_items

  def add_product(product)
    @cart_items = [] if @cart_items.nil?
    current_item = @cart_items.find { |item| item.product == product }
    if current_item
      current_item.increment_quantity
    else
      @cart_items << CartItem.new(product)
    end
  end
end
