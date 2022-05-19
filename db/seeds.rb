# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

User.destroy_all

params = { customer: { email: 'cust@test.com', password: '123456', full_name: 'Anna Smith', phone: '0400040004', address_attributes: { street: '3 Station St', city: 'Melbourne', postcode: 3001 } } }
customer = User.create!(params[:customer])
customer.add_role :customer

4.times do
    full_name = Faker::Company.name
    email = Faker::Internet.free_email(name: full_name)
    password = '123456'
    phone = Faker::Number.leading_zero_number(digits: 10)
    street = Faker::Address.street_address
    city = 'Melbourne'
    postcode = 3000
    name1 = Faker::Food.vegetables
    description1 = Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4)
    price1 = Faker::Number.within(range: 15..22)
    name2 = Faker::Food.vegetables
    description2 = Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4)
    price2 = Faker::Number.within(range: 15..22)
    name3 = Faker::Food.vegetables
    description3 = Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4)
    price3 = Faker::Number.within(range: 15..22)
    name4 = Faker::Food.vegetables
    description4 = Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4)
    price4 = Faker::Number.within(range: 15..22)
    available = true
    params = { restaurant: { email: email, password: password, full_name: full_name, phone: phone, address_attributes: { street: street, city: city, postcode: postcode } } }
    restaurant = User.create!(params[:restaurant])
    restaurant.add_role :restaurant
    restaurant.menu_items.create!(name: name1, description: description1, price: price1, available: available)
    restaurant.menu_items.create!(name: name2, description: description2, price: price2, available: available)
    restaurant.menu_items.create!(name: name3, description: description3, price: price3, available: available)
    restaurant.menu_items.create!(name: name4, description: description4, price: price4, available: available)
end

puts "Users: #{User.count}"
puts "Roles: #{Role.count}"
puts "Adresses: #{Address.count}"
puts "Menu Items: #{MenuItem.count}"
