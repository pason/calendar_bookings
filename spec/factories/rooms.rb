FactoryBot.define do
  factory :room do
    number { Faker::Number.unique.between(1, 100) }
    name { Faker::Lorem.word }
    size { 'single' }
  end
end