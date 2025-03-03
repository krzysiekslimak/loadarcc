FactoryBot.define do
  factory :load do
    trait :pallets5 do
      load_type { 'pallets5' }
    end

    trait :pallets10 do
      load_type { 'pallets10' }
    end

    trait :pallets26 do
      load_type { 'pallets26' }
    end

    load_type { 'pallets5' }
  end
end
