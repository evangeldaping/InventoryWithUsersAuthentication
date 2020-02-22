class Warehouse < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :products, through: :stocks
  has_many :orders, dependent: :destroy

  validates :street, presence: true
  validates :city, presence: true
  validates :province, presence: true

  def full_address
    "#{street}, #{city}, #{province}"
  end
end
