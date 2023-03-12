class CartItem < ApplicationRecord
  belongs_to :cart
  has_one :product

  def product
    Product.find_by(id: product_id)
  end
end
