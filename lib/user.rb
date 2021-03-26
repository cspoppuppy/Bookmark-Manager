require_relative 'db'
require 'bcrypt'

class User
  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end

  def self.create(email, password)
    encrypted_pwd = BCrypt::Password.create(password)
    sql = "INSERT INTO users (email, password) VALUES ('#{email}', '#{encrypted_pwd}') RETURNING id, email;"
    result = DB.query(sql)
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.find(id)
    return nil unless id

    sql = "SELECT * FROM users WHERE id='#{id}';"
    result = DB.query(sql)
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.sign_in(email, password)
    sql = "SELECT * FROM users WHERE email='#{email}'"
    result = DB.query(sql)
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password

    User.new(id: result[0]['id'], email: result[0]['email'])
  end
end
