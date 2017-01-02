module ApplicationHelper
	def flash_class(level)
		case level
		when 'success' then 'ui green message'
		when 'error' then 'ui red message'
		when 'notice' then 'ui blue message'
		end
	end

	def full_name(object)
    object.first_name.capitalize + ' ' + object.last_name.capitalize
  end
  
end
