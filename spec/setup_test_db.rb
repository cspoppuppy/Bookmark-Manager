require 'db'

def setup_test_db
  DB.setup("bookmark_manager_test")
  DB.query("DROP TABLE bookmarks")
  DB.query("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60));")
  DB.query("INSERT INTO bookmarks (url) VALUES ('https://google.com'), ('https://youtube.com')")
end
