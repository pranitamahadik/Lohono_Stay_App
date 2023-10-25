class Calender < ApplicationRecord
  belongs_to :villa

  validates :start_date, :end_date, :rate_per_night, presence: true
  #validates_format_of :start_date, :with => /^\d{2}\/\d{2}\/\d{4}$/, multiline: true, :message => "^Date must be in the following format: mm/dd/yyyy"
  validate :validate_end_date_before_start_date

  def validate_end_date_before_start_date
    if end_date && start_date
      errors.add(:end_date, "must be after the start date") if end_date < start_date 
    end
  end

end