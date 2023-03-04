class Product < ApplicationRecord
  belongs_to :user

  def self.find_products_for_sale
    Product.all.order(:title)
  end

  validates_presence_of :title, :description, :image_url
  validates_numericality_of :price
  validates_uniqueness_of :title

  protected

  def validate
    errors.add(:price, 'should be at least 0.01') if price.nil? || price < 0.01
  end
end
