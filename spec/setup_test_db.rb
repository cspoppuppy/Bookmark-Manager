require 'db'

def setup_test_db
  DB.setup("bookmark_manager_test")
  DB.query("DROP TABLE bookmarks")
  DB.query("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(50));")
  DB.query("INSERT INTO bookmarks (url, title) VALUES ('https://google.com', 'Google'), ('https://youtube.com', 'Youtube')")
end
