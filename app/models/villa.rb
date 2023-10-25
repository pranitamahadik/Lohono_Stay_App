class Villa < ApplicationRecord
	has_one :calender

	validates :name, presence: true
	validates :name, uniqueness: true
end
