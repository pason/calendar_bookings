class Booking < ActiveRecord::Base
  belongs_to :room

  validates_presence_of :end, :start, :room_id
  validate :overlap_dates


  def overlap_dates
        
    #errors[:start_date] << "dates overlap with themself"
  end
end
