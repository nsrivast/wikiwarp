class CreateWarps < ActiveRecord::Migration
  def change
    create_table :warps do |t|
      t.integer :user_id
      t.integer :samplegame_id
      t.integer :difficulty
      t.integer :score
      t.integer :links
      t.integer :time
      t.string :start
      t.string :target
      t.string :path
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
