class AddAccountRelationships < ActiveRecord::Migration
  def change
    add_column :users, :account_id, :integer
    add_column :locations, :account_id, :integer


    add_index :users, :account_id
    add_index :locations, :account_id
  end
end
