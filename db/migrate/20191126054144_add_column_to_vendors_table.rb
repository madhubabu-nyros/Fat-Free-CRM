class AddColumnToVendorsTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :vendors, :access, :string
  end
end
