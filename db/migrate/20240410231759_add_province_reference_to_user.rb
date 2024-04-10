class AddProvinceReferenceToUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :province
    add_reference :users, :province, null: false, foreign_key: true
    add_foreign_key :users, :province, column: :province_id
  end
end
