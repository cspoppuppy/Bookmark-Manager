feature 'add bookmark' do
  scenario 'add bookmark to database and display' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://test.com')
    fill_in('title', with: 'test')
    click_button('Submit')
    expect(page).to have_link('test', href: 'http://test.com')
  end

  scenario 'must be valid url' do
    visit('/bookmarks/new')
    fill_in('title', with: 'test')
    fill_in('url', with: 'test')
    click_button('Submit')
    expect(page).to have_content("Invalid URL")
  end
end
