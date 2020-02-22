FactoryBot.define do
  factory :order_item do
    order { Order.first || association(:order) }
    product { Product.first || association(:product) }
    quantity { 1 }
  end
end
