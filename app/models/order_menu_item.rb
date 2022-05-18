class OrderMenuItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item

  def total_price
    return menu_item.price * quantity
  end
end
