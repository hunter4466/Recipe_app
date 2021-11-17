require 'rails_helper'

RSpec.describe 'Login page', js: true, type: :system do
  before(:all) do
    user1 = User.create({ name: 'Foo', email: 'user1@mail.com', password: '111111', confirmed_at: '2021-01-01' })
    user2 = User.create({ name: 'Bar', email: 'user2@mail.com', password: '111111', confirmed_at: '2021-01-01' })
    recipe1 = Recipe.create({ name: 'Sandwich', preparation_time: '1h', cooking_time: '2h', description: 'Make a Sandwich', user_id: user1.id })
    recipe2 = Recipe.create({ name: 'Burger', preparation_time: '1h', cooking_time: '2h', description: 'Make a Burger', user_id: user1.id })
  end

  describe 'contains' do
    it 'Username and password inputs, and Log in button' do
      visit new_user_session_path
      expect(page).to have_field('email')
      expect(page).to have_field('password')
      expect(page).to have_button('Log in')
    end
  end

  describe 'when I click the submit button' do
    it 'without filling in the username and the password, I get a detailed error' do
      visit new_user_session_path
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'after filling in the username and the password with incorrect data, I get a detailed error' do
      visit new_user_session_path
      fill_in 'email', with: 'wrong_user@email.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'after filling in the username and the password with correct data, I am redirected to the root page' do
      visit new_user_session_path
      fill_in 'email', with: 'user1@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end
  end
end
