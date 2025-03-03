FactoryBot.define do
  factory :route do
    from { Faker::Address.city }
    to { Faker::Address.city }
  end
end
