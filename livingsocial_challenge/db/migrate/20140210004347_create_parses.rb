class CreateParses < ActiveRecord::Migration
  def change
    create_table :parses do |t|
      t.string :purchaser_name
      t.string :item_description
      t.integer :item_price
      t.integer :purchase_count
      t.string :merchant_address
      t.string :merchant_name

      t.timestamps
    end
  end
end
