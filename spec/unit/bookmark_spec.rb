require 'bookmark'
require_relative '../setup_test_db'

describe Bookmark do
  setup_test_db

  describe '#add' do
    it 'adds url to database' do
      url = "test"
      sql = "INSERT INTO bookmarks (url) VALUES ('test');"
      expect(DB).to receive(:query).with(sql)
      Bookmark.add(url)
    end
  end

  describe '#items' do
    it 'shows all bookmarks' do
      bookmarks = Bookmark.items
      expect(bookmarks).to include("https://google.com")
      expect(bookmarks).to include("https://youtube.com")
    end
  end
end
