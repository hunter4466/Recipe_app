require 'rails_helper'

RSpec.describe 'in a post page', js: true, type: :system do
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
    it 'the post\'s title' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content(user.posts.last.title)
    end

    it 'who wrote the post' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content(user.name)
    end

    it 'how many comments it has' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content("Comments: #{user.posts.last.comments_counter}")
    end

    it 'how many likes it has' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content("Likes: #{user.posts.last.likes_counter}")
      click_button 'Like'
      expect(page).to have_content("Likes: #{user.posts.last.likes_counter}")
    end

    it 'the post body' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content(user.posts.last.text)
    end

    it 'the username of each commentor' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      click_link user.name
      click_link user.posts.last.title
      user.posts.last.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'the comment each commentor left' do
      visit new_user_session_path
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: '111111'
      click_button 'Log in'
      user = User.find_by(name: 'Foo')
      click_link user.name
      click_link user.posts.last.title
      user.posts.last.comments.each do |comment|
        expect(page).to have_content("#{comment.author.name}: #{comment.text}")
      end
    end
  end
end
