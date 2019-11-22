class VendorPdf < Prawn::Document
	def initialize(vendors)
		super()
		@vendors = vendors
		vendor_list
	end

	def vendor_list
		move_down 20
		table vendor_list_rows do
			row(0).font_style = :bold
		end
	end

	def vendor_list_rows
		[["Name", "Email", "Phone", "Products"]] + 
		@vendors.map do |vendor|
			[vendor.name, vendor.email, vendor.phone,
				vendor.product_lists.map do |v|
					[v.product.name]
				end 
			]
		end
	end
end