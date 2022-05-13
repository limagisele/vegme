class Order < ApplicationRecord
  belongs_to :user
  has_many :order_menu_items
  has_many :menu_items, through: :order_menu_items
  
  def order_total_price
    order_menu_items.map { |order_item| order_item.menu_item.price * order_item.quantity }.sum
  end
end
