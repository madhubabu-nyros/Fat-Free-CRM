class ChangeJobsTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :vendors, :assigned_to, :string
  end
end
