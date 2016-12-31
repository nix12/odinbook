# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(first_name: 'Tyrion', 
						last_name: 'Lannister', 
						email: 'foobar@example.com',
						password: 'foobar', 
						password_confirmation: 'foobar')

99.times do |n|
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	email = "example-#{ n+1 }@example.com"
	password = 'foobar'

	User.create(first_name: first_name, 
						last_name: last_name, 
						email: email,
						password: password, 
						password_confirmation: password)
end