# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create({ name: 'John id 1', email: 'user1@mail.com', password: '111111', confirmed_at: '2021-01-01' })
user2 = User.create({ name: 'Foo id 2', email: 'user2@mail.com', password: '111111', confirmed_at: '2021-01-01' })
user3 = User.create({ name: 'Bar id 3', email: 'user3@mail.com', password: '111111', confirmed_at: '2021-01-01' })
recipe1 = Recipe.create({name: 'Sandwich', preparation_time: '1h', cooking_time: '2h', description: 'Make a Sandwich', user_id: user1.id})
recipe2 = Recipe.create({name: 'Burger', preparation_time: '1h', cooking_time: '2h', description: 'Make a Burger', user_id: user1.id})
recipe3 = Recipe.create({name: 'Hot Dog', preparation_time: '1h', cooking_time: '2h', description: 'Make a Hot Dog', user_id: user1.id})
food1 = Food.create({name: 'Ham', measurement_unit: 'Kg', price: 20, user_id: user1.id})
food2 = Food.create({name: 'Cheese', measurement_unit: 'Kg', price: 10, user_id: user1.id})
food3 = Food.create({name: 'Bread', measurement_unit: 'Kg', price: 5, user_id: user1.id})
food4 = Food.create({name: 'Sausage', measurement_unit: 'Kg', price: 3, user_id: user1.id})
recipe_food1 = RecipeFood.create({quantity: 2, food_id: food1.id, recipe_id: recipe1.id})
recipe_food2 = RecipeFood.create({quantity: 2, food_id: food2.id, recipe_id: recipe1.id})
recipe_food3 = RecipeFood.create({quantity: 2, food_id: food3.id, recipe_id: recipe1.id})
recipe_food4 = RecipeFood.create({quantity: 2, food_id: food4.id, recipe_id: recipe3.id})
