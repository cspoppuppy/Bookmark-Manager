require 'bookmark'
require_relative '../setup_test_db'

describe Bookmark do
  setup_test_db

  describe '.add' do
    it 'adds url to database' do
      url = "test"
      title = "test"
      sql = "INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title;"
      expect(DB).to receive(:query).with(sql).and_return([{"id" => "3", "url" => "test", "title" => "test"}])
      Bookmark.add(url, title)
    end
  end

  describe '.items' do
    it 'shows all bookmarks' do
      bookmarks = Bookmark.items
      expect(bookmarks.first).to be_a Bookmark
      # expect(bookmarks.first.title).to eq "Google"
    end
  end

  describe '.delete' do 
    it 'deletes a bookmark' do
      bookmarks = Bookmark.items
      sql = "DELETE FROM bookmarks WHERE id = '#{bookmarks[0].id}';"
      expect(DB).to receive(:query).with(sql)
      Bookmark.delete(bookmarks[0].id)
    end
  end 

  describe '.update' do
    it 'update a bookmark' do
      bookmarks = Bookmark.items
      id = bookmarks[0].id
      sql = "UPDATE bookmarks SET title='test', url='test' WHERE id='#{id}'"
      expect(DB).to receive(:query).with(sql)
      Bookmark.update(id, 'test', 'test')
    end
  end

  describe '.find' do
    it 'find item from database' do
      bookmarks = Bookmark.items
      expect(Bookmark.find(bookmarks[0].id).title).to eq bookmarks[0].title
    end
  end
end
