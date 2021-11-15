RSpec.describe 'Login page', js: true, type: :system do
  before(:all) do
    @first_user = User.create(name: 'Mario', photo: 'http://lorempixel.com/100/100/',
                              bio: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudi.',
                              posts_counter: 0, email: 'mariochois@gmail.com', password: 'jf7l2p93li', confirmed_at: Time.now)
    @second_user = User.create(name: 'Renato', photo: 'http://lorempixel.com/100/100/',
                               bio: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudi.',
                               posts_counter: 0, email: 'renato@gmail.com', password: 'jf7l2p93li', confirmed_at: Time.now)
    @first_post = Post.create(title: 'Post 1', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit.',
                              author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @second_post = Post.create(title: 'Post 2', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit.',
                               author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @third_post = Post.create(title: 'Post 3', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit.',
                              author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @fourth_post = Post.create(title: 'Post 4', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit.',
                               author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    Comment.create(text: 'This is the first comment', author_id: @second_user.id, post_id: @fourth_post.id)
    Comment.create(text: 'This is the second comment', author_id: @first_user.id, post_id: @fourth_post.id)
  end

  describe 'contains' do
    it 'username and password inputs, and Log in button' do
      visit new_user_session_path
      expect(page).to have_field('email')
      expect(page).to have_field('password')
      expect(page).to have_button('Log in')
    end
  end

  describe 'Click the submit button' do
    it 'without filling in the username and the password, I get a detailed error' do
      visit new_user_session_path
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Filling in the username and the password with incorrect data results in get a detailed error' do
      visit new_user_session_path
      fill_in 'email', with: 'user@example.com'
      fill_in 'password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Filling in the username and the password with correct data results in redirect to the root page' do
      visit new_user_session_path
      fill_in 'email', with: 'mariochois@gmail.com'
      fill_in 'password', with: 'jf7l2p93li'
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end
  end
end
