class AddIndexForLikeUserIds < ActiveRecord::Migration
  def change
    execute <<-SQL
      CREATE INDEX like_user_ids_idx ON movies USING gist(like_user_ids gist__intbig_ops);
    SQL
  end
end
