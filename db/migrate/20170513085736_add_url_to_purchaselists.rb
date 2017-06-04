class AddUrlToPurchaselists < ActiveRecord::Migration
  def change
    add_column :purchaselists, :url, :string
  end
end
