class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.string :description
      t.decimal :price, precision: 5, scale: 2
      t.boolean :available

      t.timestamps
    end
  end
end
