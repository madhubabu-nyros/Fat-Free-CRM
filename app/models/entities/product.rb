class Product < ApplicationRecord
	has_many :product_lists
	has_many :vendors, through: :product_lists
end
