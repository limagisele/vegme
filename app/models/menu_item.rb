class MenuItem < ApplicationRecord
    belongs_to :user
    has_one_attached :photo
    has_many :order_menu_items
    has_many :orders, through: :order_menu_items

end
