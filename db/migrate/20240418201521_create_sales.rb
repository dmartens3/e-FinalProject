class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.integer :quantity
      t.decimal :cost
      t.decimal :tax
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
