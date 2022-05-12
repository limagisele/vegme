class AddQuantityToOrderMenuItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_menu_items, :quantity, :integer
  end
end
