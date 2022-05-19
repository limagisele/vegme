class MenuItem < ApplicationRecord
    belongs_to :user
    has_one_attached :photo, dependent: :destroy
    has_many :order_menu_items, dependent: :destroy
    has_many :orders, through: :order_menu_items, dependent: :destroy
    validates :name, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 30, maximum: 400 }
    validates :price, presence: true, numericality: { in: 1..99 }
    validates :available, presence: true
    after_commit :add_default_photo, on: [:create, :update]

    private

    def add_default_photo
        unless photo.attached?
            self.photo.attach(io: File.open(Rails.root.join("app", "assets", "images", "no-img.png")), filename: 'no-img.png', content_type: "image/png")
        end
    end
end
