require 'bundler'
require 'pry'
require 'dotenv/load'
#require 'date'
Bundler.require

require_all 'app/model'





ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

