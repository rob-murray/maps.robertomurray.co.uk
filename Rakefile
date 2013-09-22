require 'rubygems'
require 'bundler'
require 'rake'
Bundler.setup

require 'active_support/core_ext'
require 'asset_sync'

namespace :assets do

  AssetSync.configure do |config|
    config.fog_provider = 'AWS'
    config.fog_directory = ENV['FOG_DIRECTORY']
    config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
    config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    config.prefix = "assets"
    config.public_path = Pathname("./public")
  end

  desc "Precompile assets"
  task :precompile do
    AssetSync.sync
  end

  desc "Sync data files"
  task :sync_data do

    AssetSync.configure do |config|
      config.prefix = "data"
      config.public_path = Pathname("./public")
    end

    AssetSync.sync
  end
end

# List of environments and their heroku git remotes
ENVIRONMENTS = {
  :staging => 'todo',
  :production => 'rm-maps-prod'
}

namespace :deploy do
  ENVIRONMENTS.keys.each do |env|
    desc "Deploy to #{env}"
    task env do
      #puts `git branch | grep ^* | awk '{ print $2 }'`.strip
      current_branch = env

      Rake::Task['deploy:before_deploy'].invoke(env, current_branch)
      Rake::Task['deploy:update_code'].invoke(env, current_branch)
      Rake::Task['deploy:after_deploy'].invoke(env, current_branch)
    end
  end

  task :before_deploy, :env, :branch do |t, args|
    
    maps_env = ENVIRONMENTS[args[:env]]#either rm-maps-prod or staging
    
    puts "Building #{maps_env} for #{args[:env]} with Build version: #{ENV['BLD']}"

    puts 'Putting the app into maintenance mode ...'
    puts `heroku maintenance:on --app #{maps_env}`
    
    #add heroku remote conf
    puts "Adding Heroku conf"
    puts "git remote add #{args[:branch]} git@heroku.com:#{maps_env}.git"
    `git remote add #{args[:branch]} git@heroku.com:#{maps_env}.git`
      
  end

  task :after_deploy, :env, :branch do |t, args|

    maps_env = ENVIRONMENTS[args[:env]]#either rm-maps-prod or staging

    puts 'Taking the app out of maintenance mode ...'
    puts `heroku maintenance:off --app #{maps_env}`

    puts "Deployment Complete!"
  end

  task :update_code, :env, :branch do |t, args|
      puts "Updating #{ENVIRONMENTS[args[:env]]} with branch #{args[:branch]}"
      puts "git push #{args[:branch]} +master"
      `git push #{args[:branch]} +master`

      #doing asset sync... for data   
      puts "Sync'ing data files with AWS S3..."
      `heroku run rake assets:sync_data`
  end

end



desc "Kick off a get request to url"
task :do_get_request_to_url, :url do |t, args|

    if args[:url] then url = args[:url] else url = ENV['URL'] end

    unless url.nil?

        require 'net/http'
        require 'uri'

        Net::HTTP.get_response(URI.parse(url))

    end
    
end