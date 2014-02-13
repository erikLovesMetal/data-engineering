class ParseUpdate < ActiveRecord::Migration
  def change
  	remove_column :parses, :item_description
  	remove_column :parses, :item_price
  	remove_column :parses, :purchase_count
  	remove_column :parses, :merchant_address
  	remove_column :parses, :merchant_name
  	rename_column :parses, :purchaser_name, :name
  end
end
