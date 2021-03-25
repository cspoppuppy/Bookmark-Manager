require 'db'

def setup_test_db
  DB.query("DROP TABLE comments")
  DB.query("DROP TABLE bookmarks")
  DB.query("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(50));")
  DB.query("INSERT INTO bookmarks (url, title) VALUES ('https://google.com', 'Google'), ('https://youtube.com', 'Youtube')")
  DB.query("CREATE TABLE comments (id SERIAL PRIMARY KEY, text VARCHAR(240), bookmark_id INTEGER REFERENCES bookmarks(id) ON DELETE CASCADE);")
end
