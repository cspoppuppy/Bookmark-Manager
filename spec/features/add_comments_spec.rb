feature 'add comment' do
  scenario 'add comment to a bookmark' do
    visit('/bookmarks')
    first('.bookmark').click_button('Add Comment')
    fill_in('comment', with: 'test comments')
    click_button('Submit')
    expect(first('.bookmark')).to have_content('test comments')
  end
end
