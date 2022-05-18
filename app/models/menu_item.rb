class MenuItem < ApplicationRecord
    belongs_to :user
    has_one_attached :photo, dependent: :destroy
    has_many :order_menu_items, dependent: :destroy
    has_many :orders, through: :order_menu_items, dependent: :destroy
    validates :name, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 30, maximum: 400 }
    validates :price, presence: true, numericality: { in: 1..99 }
    validates :available, presence: true
end
