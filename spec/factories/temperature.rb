FactoryBot.define do
  factory :temperature do
    trait :cold do
      type { Temperature.types[:cold] }
      min { 0 }
      max { 18 }
    end

    trait :warm do
      type { Temperature.types[:warm] }
      min { 19 }
      max { 28 }
    end

    trait :hot do
      type { Temperature.types[:hot] }
      min { 29 }
      max { 50 }
    end
  end
end
