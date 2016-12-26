class UserMailer < ApplicationMailer
	default from: 'notification@example.com'

	def send_welcome_email(user)
		@user = user
		@url = 'immense-gorge-61510.herokuapp.com/'

		mail to: @user.email, subject: 'Welcome to Odinbook!'
	end
end
