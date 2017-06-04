class CreatePurchaselists < ActiveRecord::Migration
  def change
    create_table :purchaselists do |t|
      t.string  :name
      t.string  :image
      t.integer :price
      t.timestamps null: false
    end
  end
end
