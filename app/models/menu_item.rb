class MenuItem < ApplicationRecord
    belongs_to :user
    has_one_attached :photo, dependent: :destroy
    has_many :order_menu_items, dependent: :destroy
    has_many :orders, through: :order_menu_items, dependent: :destroy

end
