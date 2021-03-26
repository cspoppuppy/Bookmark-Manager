require 'db'

def setup_test_db
  DB.query("DROP TABLE IF EXISTS users")
  DB.query("DROP TABLE IF EXISTS bookmark_tags;")
  DB.query("DROP TABLE IF EXISTS tags;")
  DB.query("DROP TABLE IF EXISTS comments;")
  DB.query("DROP TABLE IF EXISTS bookmarks;")
  DB.query("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(50));")
  DB.query("INSERT INTO bookmarks (url, title) VALUES ('https://google.com', 'Google'), ('https://youtube.com', 'Youtube')")
  DB.query("CREATE TABLE comments (id SERIAL PRIMARY KEY, text VARCHAR(240), bookmark_id INTEGER REFERENCES bookmarks(id) ON DELETE CASCADE);")
  DB.query("CREATE TABLE tags (id SERIAL PRIMARY KEY, content VARCHAR(60));")
  DB.query("CREATE TABLE bookmark_tags (id SERIAL PRIMARY KEY, bookmark_id INTEGER REFERENCES bookmarks(id) ON DELETE CASCADE, tag_id INTEGER REFERENCES tags(id) ON DELETE CASCADE);")
  DB.query("CREATE TABLE users (id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(140));")
end
