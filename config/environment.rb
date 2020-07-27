require 'bundler'
Bundler.require

require 'uri'
require 'net/http'
require 'openssl'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
