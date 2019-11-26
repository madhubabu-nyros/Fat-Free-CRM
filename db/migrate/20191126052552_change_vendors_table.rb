class ChangeVendorsTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :venodrs, :user_id, :integer
  end
end
