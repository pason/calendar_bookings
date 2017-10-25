require 'rails_helper'

RSpec.describe Booking, type: :model do

  describe "Associations" do
    it { should belong_to(:room) }
  end
  
  describe "Validations" do
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:end) }
    it { should validate_presence_of(:room_id) }
  end
end
