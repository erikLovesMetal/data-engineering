class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :purchaser_name
      t.string :item_description
      t.integer :price
      t.integer :count
      t.string :merchant_address
      t.string :merchant_name

      t.timestamps
    end
  end
end
