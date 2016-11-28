class RegistrationsController < Devise::RegistrationsController
	protected

		def after_sign_up_path_for(resource)
			user_path(@user)
		end

		def after_sign_in_path_for(resource)
			user_path(@user)
		end
end
