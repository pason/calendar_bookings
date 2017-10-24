FactoryBot.define do
  factory :booking do
    add_attribute(:start) { Faker::Date.backward(14) }
    add_attribute(:end) { Faker::Date.backward(7) }
    room_id nil
  end
end