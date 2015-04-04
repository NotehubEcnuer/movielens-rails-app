class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :age
      t.string :gender
      t.integer :occupation_id
      t.string :zip_code

      t.timestamps null: false
    end
  end
end
