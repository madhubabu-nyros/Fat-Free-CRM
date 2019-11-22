class ProductList < ApplicationRecord
  belongs_to :vendor
  belongs_to :product

  validates :product_id, :presence => true
end
