require 'rails_helper'

RSpec.describe 'in Index page', js: true, type: :system do
  before(:all) do
    @first_user = User.create(name: 'Foo', photo: 'photo',
                              bio: 'Awesome bio',
                              posts_counter: 0, email: 'user@mail.com', password: '111111', confirmed_at: Time.now)
    @second_user = User.create(name: 'Bar', photo: 'photo',
                               bio: 'Awesome bio',
                               posts_counter: 0, email: 'test@mail.com', password: '111111', confirmed_at: Time.now)
    @first_post = Post.create(title: 'Title 1', text: 'Lorem ipsum',
                              author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @second_post = Post.create(title: 'Title 2', text: 'Lorem ipsum',
                               author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @third_post = Post.create(title: 'Title 3', text: 'Lorem ipsum',
                              author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @fourth_post = Post.create(title: 'Title 4', text: 'Lorem ipsum',
                               author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    Comment.create(text: 'Wow comment', author_id: @second_user.id, post_id: @fourth_post.id)
    Comment.create(text: 'Best comment', author_id: @first_user.id, post_id: @fourth_post.id)
  end

  describe 'I can see' do
    it 'the username of all other users' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      users = User.all
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'the profile picture for each user' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      users = User.all
      visit users_path
      expect(page).to have_content(users[0].photo)
    end

    it 'the number of posts each user has written' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      users = User.all
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end
  end

  describe 'when I click on a user, ' do
    it 'I am redirected to that user\'s show page' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(current_path).to eql(user_path(id: users[0].id))
    end
  end
end
