class User < ApplicationRecord
  rolify
  has_many :menu_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  validates :full_name, presence: true, length: { in: 3..30 }
  validates :phone, length: { in: 10..12 }, numericality: { only_integer: true }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def with_address
    build_address if address.nil?
    self
  end

end
