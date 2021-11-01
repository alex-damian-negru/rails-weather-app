# frozen_string_literal: true

FactoryBot.define do
  factory :temperature do
    trait :cold do
      type { Temperature::TYPES[:cold] }
      min { 0 }
      max { 18 }
    end

    trait :warm do
      type { Temperature::TYPES[:warm] }
      min { 19 }
      max { 28 }
    end

    trait :hot do
      type { Temperature::TYPES[:hot] }
      min { 29 }
      max { 50 }
    end
  end
end
