require_relative 'db'

class Tag
  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end
  
  def self.add(content)
    sql = "INSERT INTO tags (content) VALUES ('#{content}') RETURNING id, content;"
    result = DB.query(sql)
    Tag.new(id: result[0]['id'], content: result[0]['content'])
  end

  def self.delete(id)
    sql = "DELETE FROM tags WHERE id = '#{id}';"
    DB.query(sql)
  end

  def self.update(id, content)
    sql = "UPDATE tags SET content='#{content}' WHERE id='#{id}';"
    DB.query(sql)
  end

  def self.items
    result = DB.query("SELECT * FROM tags;")
    p result
    result.map do |tag|
      Tag.new(id: tag['id'], content: tag['content'])
    end
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id='#{id}';"
    result = DB.query(sql)
    Tag.new(id: result[0]['id'], content: result[0]['content'])
  end

  def bookmarks
    sql = "SELECT * FROM bookmark_tags WHERE tag_id='#{@id}'"
    result = DB.query(sql)
    result.map do |bookmark|
      Bookmark.find(bookmark['bookmark_id'])
    end
  end
end
