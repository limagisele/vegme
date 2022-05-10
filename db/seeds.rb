# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Address.destroy_all
MenuItem.destroy_all
User.destroy_all

params = { customer: { email: 'c@test.com', password: '123456', full_name: 'Anna', phone: '04000400', address_attributes: { street: '3 Station St', city: 'Melbourne', postcode: 3001 } } }
customer = User.create(params[:customer])
customer.add_role :customer

params1 = { restaurant1: { email: 'r1@test.com', password: '123456', full_name: 'VeBurgers', phone: '04110411', address_attributes: { street: '120 King St', city: 'Melbourne', postcode: 3000 } } }
restaurant1 = User.create(params1[:restaurant1])
restaurant1.add_role :restaurant

params2 = { restaurant2: { email: 'r2@test.com', password: '123456', full_name: 'Pizza Vegs', phone: '04220422', address_attributes: { street: '67 Elizabeth St', city: 'Melbourne', postcode: 3002 } } }
restaurant2 = User.create(params2[:restaurant2])
restaurant2.add_role :restaurant

restaurant1.menu_items.create(name: 'Veggie Burger', description: 'Delicious burger with chickpea patty, lettuce, tomato and BBQ sauce', price: 18, available: true)
restaurant1.menu_items.create(name: 'Falafel Burger', description: 'Falafel patty with hummus and salad', price: 16, available: true)
restaurant2.menu_items.create(name: 'Super Veggie Pizza', description: 'Vegan cheese, eggplant, mushroom, capsicum and olives', price: 15, available: false)
restaurant2.menu_items.create(name: 'Hawaiian Pizza', description: 'Vegan cheese, pineaple and vegan ham', price: 17, available: true)

puts "Users: #{User.count}"
puts "Roles: #{Role.count}"
puts "Adresses: #{Address.count}"
puts "Menu Items: #{MenuItem.count}"
