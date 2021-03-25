feature 'delete bookmark' do
  scenario 'click delete button to delete a bookmark' do
    visit('/bookmarks')
    expect(page).to have_link('Google', href: 'https://google.com')

    first('.bookmark').click_button 'Delete'
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Google', href: 'https://google.com')
  end
end
