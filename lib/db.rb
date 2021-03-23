require 'pg'

class DB
  def self.setup(db_name)
    @conn = PG.connect(dbname: db_name)
  end

  def self.connection
    @conn
  end

  def self.query(sql)
    @conn.exec(sql)
  end
end