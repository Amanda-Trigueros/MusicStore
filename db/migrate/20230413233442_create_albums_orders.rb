class CreateAlbumsOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :albums_orders do |t|
      t.references :order, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true
      t.integer :album_copies

      t.timestamps
    end
  end
end
