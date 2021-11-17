require 'rails_helper'

RSpec.describe 'in user show page', js: true, type: :system do
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
    it 'the user\'s profile picture' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page).to have_content(users[0].photo)
    end

    it 'the user\'s username' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page).to have_content(users[0].name)
    end

    it 'the number of posts the user has written' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page).to have_content("Number of posts: #{users[0].posts_counter}")
    end

    it 'the user\'s bio' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page).to have_content(users[0].bio)
    end

    it 'the user\'s first 3 posts' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      click_link user.name
      expect(page).to have_content(user.posts[3].title)
      expect(page).to have_content(user.posts[2].title)
      expect(page).to have_content(user.posts[1].title)
      expect(page).to_not have_content(user.posts[0].title)
    end

    it 'a button that lets me view all of a user\'s posts' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      click_link user.name
      expect(page).to have_link('See all posts')
    end
  end

  describe 'when I click' do
    it 'a user\'s post, it redirects me to that post\'s shot page' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      click_link user.name
      click_link user.posts.last.title
      expect(current_path).to eql(user_post_path(id: user.posts.last.id, user_id: user.id))
    end
  end
end
