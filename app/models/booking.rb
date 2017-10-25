class Booking < ActiveRecord::Base
  alias_attribute :start_date, :start
  alias_attribute :end_date, :end

  belongs_to :room

  validates_presence_of :end, :start, :room_id
  validate :validate_overlap_dates

  scope :overlappings, lambda { |start_date, end_date|  
    where('(start <= :start_date AND end >= :start_date) OR 
           (start <= :end_date AND end >= :end_date) OR 
           (start >= :start_date AND end <= :end_date)', 
           start_date: start_date, 
           end_date: end_date )  
  }

  def validate_overlap_dates
    return unless room.present?
    return unless room.bookings.overlappings(start_date, end_date).any?
    %w(start, end).each { |attr| errors[attr] << "{attr} date overlaps with existing booking" } 
  end
end
