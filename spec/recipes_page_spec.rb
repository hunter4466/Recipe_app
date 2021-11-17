require 'rails_helper'

RSpec.describe 'in user recipes index page', js: true, type: :system do
  before(:all) do
    user1 = User.create({ name: 'Foo', email: 'user1@mail.com', password: '111111', confirmed_at: '2021-01-01' })
    user2 = User.create({ name: 'Bar', email: 'user2@mail.com', password: '111111', confirmed_at: '2021-01-01' })
    recipe1 = Recipe.create({ name: 'Sandwich', preparation_time: '1h', cooking_time: '2h', description: 'Make a Sandwich', user_id: user1.id })
    recipe2 = Recipe.create({ name: 'Burger', preparation_time: '1h', cooking_time: '2h', description: 'Make a Burger', user_id: user1.id })
    food1 = Food.create({ name: 'Ham', measurement_unit: 'Kg', price: 20, user_id: user1.id })
    food2 = Food.create({ name: 'Cheese', measurement_unit: 'Kg', price: 10, user_id: user1.id })
    recipe_food1 = RecipeFood.create({ quantity: 2, food_id: food1.id, recipe_id: recipe1.id })
    recipe_food2 = RecipeFood.create({ quantity: 3, food_id: food2.id, recipe_id: recipe1.id })
  end

  describe 'I can see' do
    it 'the description for each recipe' do
      visit new_user_session_path
      fill_in 'email', with: 'user1@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_content(recipe.description)
    end

    it 'the recipe\'s name' do
      visit new_user_session_path
      fill_in 'email', with: 'user1@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_content(recipe.name)
    end

    it 'the recipe\'s preparation time' do
      visit new_user_session_path
      fill_in 'email', with: 'user1@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_content(recipe.preparation_time)
    end

    it 'the recipe\'s cooking time' do
      visit new_user_session_path
      fill_in 'email', with: 'user1@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_content(recipe.cooking_time)
    end

    it 'the Generate shopping list button' do
      visit new_user_session_path
      fill_in 'email', with: 'user1@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_button('Generate shopping list')
    end

    it 'the recipe\'s food list' do
      visit new_user_session_path
      fill_in 'email', with: 'user1@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_content('Ham')
    end

    it 'the Make public button' do
      visit new_user_session_path
      fill_in 'email', with: 'user1@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      click_link 'Sandwich'
      expect(page).to have_button('Make Public')
    end

    it 'the Remove button' do
      visit new_user_session_path
      fill_in 'email', with: 'user1@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_button('Remove')
    end
  end

  describe 'when I click' do
    it 'on Generate shopping list, it redirects me to shopping list page' do
      visit new_user_session_path
      fill_in 'email', with: 'user1@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      click_button 'Generate shopping list'
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Price')
    end
  end
end
