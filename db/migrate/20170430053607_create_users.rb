class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :mail
      t.string  :password_digest
      t.integer :grade
      t.boolean :isadmin
      t.timestamps null: false
    end
  end
end
