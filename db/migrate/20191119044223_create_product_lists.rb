class CreateProductLists < ActiveRecord::Migration[5.1]
  def change
    create_table :product_lists do |t|
      t.belongs_to :vendors, foreign_key: true
      t.belongs_to :products, foreign_key: true

      t.timestamps
    end
  end
end
