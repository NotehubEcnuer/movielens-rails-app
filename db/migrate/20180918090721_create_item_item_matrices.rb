class CreateItemItemMatrices < ActiveRecord::Migration
  def change
    create_table :item_item_matrix, :id => false do |t|
      t.integer :u_id
      t.integer :v_id
      t.float :sim_score, :default => 0
    end
    add_index :item_item_matrix, [:u_id, :v_id], :unique => true
  end
end
