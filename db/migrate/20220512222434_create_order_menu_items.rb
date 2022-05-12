class CreateOrderMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_menu_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :menu_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
