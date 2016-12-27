class UserMailer < ApplicationMailer
	default from: 'notification@example.com'

	def send_welcome_email(user)
		@user = user
		mail to: @user.email, subject: 'Welcome to Odinbook!'
	end
end
