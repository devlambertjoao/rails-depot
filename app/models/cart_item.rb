class CartItem < ApplicationRecord
  belongs_to :cart
  att_reader :quantity
  has_one :product

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
