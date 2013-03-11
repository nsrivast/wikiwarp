class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :hashed_password
      t.string :email
      t.string :name
      t.string :location
      t.string :school
      t.datetime :created_at
      t.datetime :updated_at
      t.string :salt
      t.integer :total_score

      t.timestamps
    end
  end
end
