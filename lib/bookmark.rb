require_relative 'db'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
    p "initialize - id: #{id}, title: #{title}"
  end
  
  def self.delete(id)
    sql = "DELETE FROM bookmarks WHERE id = '#{id}';"
    connect_db
    DB.query(sql)
  end


  def self.add(url, title)
    sql = "INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title;"
    connect_db
    result = DB.query(sql)
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.items
    connect_db
    result = DB.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.connect_db
    db_name = ENV['DB_ENV'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
    DB.setup(db_name)
  end
end
