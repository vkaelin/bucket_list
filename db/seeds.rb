# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create an admin User and a registered User.
admin = User.create! email: 'valentin@epfl.ch', password: '1234', name: 'Valentin', role: 'admin'

user1 = User.create! email: 'paula@extensionschool.ch', password: 'password', name: 'Paula'

user2 = User.create! email: 'adam@extensionschool.ch', password: 'password', name: 'Adam'

user3 = User.create! email: 'sarah@extensionschool.ch', password: 'password', name: 'Sarah'

5.times do |i|
  Idea.create! title: "Idea for #{admin.name} #{i+1}", user: admin
  Idea.create! title: "Idea for #{user1.name} #{i+1}", user: user1
  Idea.create! title: "Idea for #{user2.name} #{i+1}", user: user2
  Idea.create! title: "Idea for #{user3.name} #{i+1}", user: user3
end

admin.goals << user1.ideas.first
admin.goals << user2.ideas.first
admin.goals << user3.ideas.first
