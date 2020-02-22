FactoryBot.define do
  factory :warehouse do
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    province { Faker::Address.state }
  end
end
