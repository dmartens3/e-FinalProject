class AddProvinceReferenceToUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :province
    add_reference :users, :province
  end
end
