class Reservation < ActiveRecord::Base
  belongs_to :user

  validate :end_after_start

  private
  def end_after_start
      return if departure_date.blank? || arrival_date.blank?

      if departure_date < arrival_date
        errors.add(:departure_date, "must be after the start date")
      end
    end
end
