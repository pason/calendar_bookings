require 'rails_helper'

RSpec.describe 'bookings API', type: :request do

  let!(:room) { create(:room) }
  let!(:booking) { create(:booking, start: Date.new(2017,1,1), end: Date.new(2017,1,7), room_id: room.id) }
  let(:room_id) { room.id }

   # Test suite for PUT /rooms/:room_id/bookings
  describe 'POST /rooms/:room_id/bookings' do
    
    context 'when request attributes are valid' do
      context 'start date day after' do
        before { post "/rooms/#{room_id}/bookings", params: {start: Date.new(2017,1,8), end: Date.new(2017,1,14)} }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'end date day before' do
        before { post "/rooms/#{room_id}/bookings", params: {start: Date.new(2016,12,30), end: Date.new(2016,12,31)} }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    end

    context 'when an invalid request' do
      context 'end date overlap' do
        before { post "/rooms/#{room_id}/bookings", params: {start: Date.new(2016,12,31), end: Date.new(2017,1,7)} }
        it_behaves_like "booking conflict"
      end

      context 'start date overlap' do
        before { post "/rooms/#{room_id}/bookings", params: {start: Date.new(2017,1,1), end: Date.new(2017,1,9)} }
        it_behaves_like "booking conflict"
      end

      context 'start & end date overlap equally' do
        before { post "/rooms/#{room_id}/bookings", params: {start: Date.new(2017,1,1), end: Date.new(2017,1,7)} }
        it_behaves_like "booking conflict"
      end

      context 'start & end date overlap inside' do
        before { post "/rooms/#{room_id}/bookings", params: {start: Date.new(2017,1,2), end: Date.new(2017,1,3)} }
        it_behaves_like "booking conflict"
      end

      context 'start & end date overlap outside' do
        before { post "/rooms/#{room_id}/bookings", params: {start: Date.new(2016,12,31), end: Date.new(2017,1,9)} }
        it_behaves_like "booking conflict"
      end
    end
  end
end
