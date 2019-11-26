class RenameColumnNamesToVendorsTable < ActiveRecord::Migration[5.1]
  def change
  	change_table :product_lists do |t|
   	 	t.rename :vendors_id, :vendor_id
    	t.rename :products_id, :product_id
	end
  end
end
