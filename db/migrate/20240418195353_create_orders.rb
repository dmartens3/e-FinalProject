class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :status, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :total

      t.timestamps
    end
  end
end
