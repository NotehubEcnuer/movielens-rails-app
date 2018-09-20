class AddIndexForIiM < ActiveRecord::Migration
  def change
    add_index :item_item_matrix, [:u_id, :sim_score, :v_id]
  end
end
