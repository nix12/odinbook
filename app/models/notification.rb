class Notification < ActiveRecord::Base
	belongs_to :recipient, class_name: 'User'

	scope :checked, -> { where(checked: true) }
	scope :unchecked, -> { where(checked: false) }
end
