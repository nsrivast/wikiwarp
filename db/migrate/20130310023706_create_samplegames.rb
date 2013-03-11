class CreateSamplegames < ActiveRecord::Migration
  def change
    create_table :samplegames do |t|
      t.string :start
      t.string :target
      t.string :estimated_difficulty
      t.string :author
      t.integer :shortest_path
      t.integer :radius
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :author_type

      t.timestamps
    end
  end
end
