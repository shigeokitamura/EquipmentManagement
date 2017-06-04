class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :name
      t.string :genre
      t.string :number
      t.string :bought
      t.boolean :isout
      t.string :place
      t.timestamps null: false
    end
  end
end
