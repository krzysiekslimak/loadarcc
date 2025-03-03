FactoryBot.define do
  factory :bid do
    amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    association :carrier
    association :route
    association :load
  end
end
