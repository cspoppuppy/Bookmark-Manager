require_relative 'db'

class Bookmark

  def self.add(url)
    sql = "INSERT INTO bookmarks (url) VALUES ('#{url}');"
    connect_db
    DB.query(sql)
  end

  def self.items
    connect_db
    result = DB.query("SELECT * FROM bookmarks;")
    result.map { |bookmark| bookmark['url'] }
  end

  def self.connect_db
    db_name = ENV['DB_ENV'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
    DB.setup(db_name)
  end
end
