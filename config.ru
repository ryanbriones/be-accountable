require 'sinatra/base'
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/lib'))

Sinatra::Base.set :run, false
Sinatra::Base.set :root, File.expand_path(File.dirname(__FILE__))
require 'be_accountable/application'

#use Rack::Reloader
run BeAccountable::Application
