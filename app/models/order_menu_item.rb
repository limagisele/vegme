class OrderMenuItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item

  def total_price
    return menu_item.price * quantity
  end

  def order_total_price
    order_menu_items.map { |order_item| order_item.price * order_item.quantity }.sum
  end
end
