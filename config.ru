# encoding: UTF-8
require './rm-maps-app'

# Sinatra config
set :app_file, 'rm-maps-app.rb'
set :root, File.dirname('rm-maps-app.rb')
set :views, 'views'
set :public_folder, 'public'

# disable any log buffering your application may be carrying out
STDOUT.sync = true

run RmMapsApp



