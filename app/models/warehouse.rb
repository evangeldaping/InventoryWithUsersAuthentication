class Warehouse < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :products, -> {distinct}, through: :stocks
  has_many :orders, dependent: :destroy

  validates :street, presence: true
  validates :city, presence: true
  validates :province, presence: true

  def full_address
    "#{street}. #{city}, #{province}"

  end

    def stock_count(product)
        stocks.where(product: product).map(&:count).compact.sum
    end

    def order_quantity(product)
      orders_with_product(product).map { |order|
        order.order_items.where(product: product).map(&:quantity)
             .compact
             .sum
      }.compact.sum
    end
    def inventory_count(product)
      stock_count(product) - order_quantity(product)
    end
    private
    def orders_with_product(product)
      orders.joins(:order_items).where(order_items: { product: product })
    end
end
