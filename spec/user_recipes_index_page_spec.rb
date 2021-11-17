require 'rails_helper'

RSpec.describe 'in user post index page', js: true, type: :system do
  before(:all) do
    user1 = User.create({ name: 'Foo', email: 'user1@mail.com', password: '111111', confirmed_at: '2021-01-01' })
    user2 = User.create({ name: 'Bar', email: 'user2@mail.com', password: '111111', confirmed_at: '2021-01-01' })
    recipe1 = Recipe.create({name: 'Sandwich', preparation_time: '1h', cooking_time: '2h', description: 'Make a Sandwich', user_id: user1.id})
    recipe2 = Recipe.create({name: 'Burger', preparation_time: '1h', cooking_time: '2h', description: 'Make a Burger', user_id: user1.id})
  end

  describe 'I can see' do
    it 'the description for each recipe' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_content(recipe.description)
    end

    it 'the recipe\'s name' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_content(recipe.name)
    end

    it 'the recipe\'s preparation time' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_content(recipe.preparation_time)
    end

    it 'the recipe\'s cooking time' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      recipe = Recipe.find_by(name: 'Sandwich')
      click_link recipe.name
      expect(page).to have_content(recipe.cooking_time)
    end

  #   it 'some of the post\'s body' do
  #     visit new_user_session_path
  #     fill_in 'email', with: 'user@mail.com'
  #     fill_in 'password', with: '111111'
  #     click_button 'Log in'
  #     user = User.find_by(name: 'Foo')
  #     click_link user.name
  #     click_link 'See all posts'
  #     expect(page).to have_content(user.posts.first.text)
  #     expect(page).to have_content(user.posts.last.text)
  #   end

  #   it 'the first comment on a post' do
  #     visit new_user_session_path
  #     fill_in 'email', with: 'user@mail.com'
  #     fill_in 'password', with: '111111'
  #     click_button 'Log in'
  #     user = User.find_by(name: 'Foo')
  #     click_link user.name
  #     click_link 'See all posts'
  #     expect(page).to have_content(user.posts.last.comments.first.text)
  #   end

  #   it 'how many comments a post has' do
  #     visit new_user_session_path
  #     fill_in 'email', with: 'user@mail.com'
  #     fill_in 'password', with: '111111'
  #     click_button 'Log in'
  #     user = User.find_by(name: 'Foo')
  #     click_link user.name
  #     click_link 'See all posts'
  #     expect(page).to have_content("Comments: #{user.posts.first.comments_counter}")
  #   end

  #   it 'how many likes a post has' do
  #     visit new_user_session_path
  #     fill_in 'email', with: 'user@mail.com'
  #     fill_in 'password', with: '111111'
  #     click_button 'Log in'
  #     user = User.find_by(name: 'Foo')
  #     click_link user.name
  #     click_link 'See all posts'
  #     expect(page).to have_content("Likes: #{user.posts.first.likes_counter}")
  #   end

  #   it 'a section for pagination if there are more posts then fit on the view' do
  #     visit new_user_session_path
  #     fill_in 'email', with: 'user@mail.com'
  #     fill_in 'password', with: '111111'
  #     click_button 'Log in'
  #     user = User.find_by(name: 'Foo')
  #     click_link user.name
  #     click_link 'See all posts'
  #     expect(page).to have_content('Pagination')
  #   end
  # end

  # describe 'when I click' do
  #   it 'on a post, it redirects me to that post\'s show page' do
  #     visit new_user_session_path
  #     fill_in 'email', with: 'user@mail.com'
  #     fill_in 'password', with: '111111'
  #     click_button 'Log in'
  #     user = User.find_by(name: 'Foo')
  #     click_link user.name
  #     click_link 'See all posts'
  #     click_link user.posts.first.title
  #     expect(current_path).to eql(user_post_path(id: user.posts.first.id, user_id: user.id))
  #   end
  # end
end
