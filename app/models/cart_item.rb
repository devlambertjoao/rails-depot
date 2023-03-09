class CartItem < ApplicationRecord
  belongs_to :cart
  has_one :product

  attr_reader :quantity

  def initialize(product)
    @product = product
    @quantity = 1
  end

  def increment_quantity
    @quantity += 1
  end

  def title
    @product.title
  end

  def private_class_method
    @product.price * @quantity
  end
end
