require_relative './lib/bookmark'

db_name = (ENV['DB_ENV'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager')
DB.setup(db_name)