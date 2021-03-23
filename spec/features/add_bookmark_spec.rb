feature 'add bookmark' do
  scenario 'add bookmark to database and display' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://test.com')
    click_button('Submit')
    expect(page).to have_content 'http://test.com'
  end
end
