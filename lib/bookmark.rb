require_relative 'db'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
    p "initialize - id: #{id}, title: #{title}"
  end
  
  def self.add(url, title)
    return false unless valid_url?(url)
    sql = "INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title;"
    result = DB.query(sql)
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id)
    sql = "DELETE FROM bookmarks WHERE id = '#{id}';"
    db_query(sql)
  end

  def self.update(id, title, url)
    sql = "UPDATE bookmarks SET title='#{title}', url='#{url}' WHERE id='#{id}'"
    db_query(sql)
  end

  def self.items
    result = db_query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.find(id)
    sql = "SELECT * FROM bookmarks WHERE id='#{id}';"
    result = db_query(sql)
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.valid_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def self.connect_db
    db_name = ENV['DB_ENV'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
    DB.setup(db_name)
  end

  def self.db_query(sql)
    DB.query(sql)
  end
end
