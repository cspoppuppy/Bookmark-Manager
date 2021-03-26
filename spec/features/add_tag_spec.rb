feature 'add tag' do
  scenario 'add tag to database and display' do
    visit('/tags/new')
    fill_in('content', with: 'tag1')
    click_button('Submit')
    expect(page).to have_content('tag1')
  end
end
