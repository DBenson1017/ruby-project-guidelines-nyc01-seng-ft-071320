require 'bundler'
require 'pry'
require 'dotenv/load'

Bundler.require

require_all 'app/model'





ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

