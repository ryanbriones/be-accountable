$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

namespace :db do
  task :auto_migrate do
    require 'dm-core'
    env = ENV['RACK_ENV'] || 'development'

    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/#{env}.sqlite3")
    require 'be_accountable/models'
    DataMapper.auto_migrate!
  end
end
