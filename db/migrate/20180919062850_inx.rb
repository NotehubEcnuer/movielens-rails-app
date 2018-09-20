class Inx < ActiveRecord::Migration
  def change
    # execute <<-SQL
    #   CREATE INDEX like_user_ids_idx_1 ON movies USING gist(like_user_ids gist__int_ops);
    # SQL

    execute <<-SQL
      CREATE INDEX like_user_ids_idx_2 ON movies USING gin(like_user_ids gin__int_ops);
    SQL
  end
end