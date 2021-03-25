feature 'update a bookmark' do
  scenario 'overwrite title and url' do
    visit('/bookmarks')
    first('.bookmark').click_button('Update')
    fill_in('title', with: 'update bookmark')
    fill_in('url', with: 'wwww.updatebookmark.com')
    click_button('Submit')
    expect(page).to have_link('update bookmark', href: 'wwww.updatebookmark.com')
  end
end
