# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

categories = Category.pluck(:id)
num_products_to_add = 120 - Product.count

num_products_to_add.times do
  name = Faker::Commerce.product_name
  description = Faker::Lorem.sentence
  price = Faker::Commerce.price(range: 0..100.0, as_string: false)

  category_id = categories.sample

  Product.create!(
    name: name,
    description: description,
    price: price,
    category_id: category_id
  )
end
