FactoryBot.define do
  factory :carrier do
    carrier_name { Faker::Company.name }
  end
end
