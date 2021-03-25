require_relative '../setup_test_db'

feature 'view bookmarks' do
  setup_test_db
  scenario 'visit /bookmarks' do
    visit('/bookmarks')
    expect(page).to have_link('Youtube', href: 'https://youtube.com')
  end
end
