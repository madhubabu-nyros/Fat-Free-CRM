class ChangeVendorsTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :vendors, :user_id, :integer
  end
end
