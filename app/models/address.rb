class Address < ApplicationRecord
  belongs_to :user

  validates :street, :city, presence: true
  validates :postcode, numericality: { only_integer: true }, length: { is: 4 }
end
