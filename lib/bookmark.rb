require_relative 'db'
require_relative 'tag'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end
  
  def self.add(url, title)
    return false unless valid_url?(url)
    sql = "INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title;"
    result = DB.query(sql)
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id)
    sql = "DELETE FROM bookmarks WHERE id = '#{id}';"
    DB.query(sql)
  end

  def self.update(id, title, url)
    sql = "UPDATE bookmarks SET title='#{title}', url='#{url}' WHERE id='#{id}';"
    DB.query(sql)
  end

  def self.items
    result = DB.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.find(id)
    sql = "SELECT * FROM bookmarks WHERE id='#{id}';"
    result = DB.query(sql)
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.valid_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def add_comment(text)
    sql = "INSERT INTO comments (text, bookmark_id) VALUES('#{text}', '#{@id}');"
    DB.query(sql)
  end

  def comments
    sql = "SELECT * FROM comments WHERE bookmark_id='#{@id}'"
    result = DB.query(sql)
  end

  def add_tag(tag_id)
    sql = "INSERT INTO bookmark_tags (bookmark_id, tag_id) VALUES('#{@id}', '#{tag_id}');"
    DB.query(sql)
  end

  def tags
    sql = "SELECT * FROM bookmark_tags WHERE bookmark_id='#{@id}'"
    result = DB.query(sql)
    result.map do |tag|
      Tag.find(tag['tag_id'])
    end
  end
end
