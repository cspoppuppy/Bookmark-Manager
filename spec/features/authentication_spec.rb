feature 'authentication' do
  scenario 'a user can sign in' do
    User.create('test@example.com', 'password123')

    visit('/sessions/new')
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'password123')
    click_button('Sign in')

    expect(page).to have_content 'Welcome, test@example.com'
  end

  scenario 'error with wrong email' do
    User.create('test@example.com', 'password123')

    visit('/sessions/new')
    fill_in(:email, with: 'notrightemail@example.com')
    fill_in(:password, with: 'password123')
    click_button('Sign in')

    expect(page).to_not have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password'
  end

  scenario 'error with wrong password' do
    User.create('test@example.com', 'password123')

    visit('/sessions/new')
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'wrongpass')
    click_button('Sign in')

    expect(page).to_not have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'user can sign out' do
    User.create('test@example.com', 'password123')
    visit('/sessions/new')
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'password123')
    click_button('Sign in')

    click_button('Sign out')

    expect(page).to_not have_content 'Welcome, test@example.com'
    expect(page).to have_content 'You have signed out.'
  end
end
