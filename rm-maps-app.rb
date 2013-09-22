#!/usr/bin/env ruby
# encoding: UTF-8

require 'bundler'
Bundler.require

class RmMapsApp < Sinatra::Base

  DATE_FORMAT = "%d.%m.%Y"

  #configure app instance : PROD
  configure :production do
    
    #turn off RACK protection from iframe
    set :protection, :except => :frame_options

    #set the asset_host to AWS S3
    set :asset_host, "//#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com/"
    
  end

  #configure app instance : DEV
  configure :development do

    set :asset_host, "/"

  end

  helpers do

    include Rack::Utils
    alias_method :h, :escape_html
    
    
    def get_page_title
      'Mapping app > robertomurray.co.uk'
    end
    
    def partial (template, locals = {})
        erb(template, :layout => false, :locals => locals)
    end
    
    def get_file_mod_date(path_to_file)
      if File.exists?(path_to_file)
        File.mtime(path_to_file)
      else
        "invalid path"
      end
    end

    def get_asset_path( asset_file )
      File.join settings.asset_host, asset_file
    end
  end

  # index view
  # /
  get '/' do
    @page_title = "home > #{get_page_title}"
    erb :index
  end

  # mr-c tweets map view
  # /mr-correcter
  get '/mr-correcter' do
    @page_title = "mr_correcter > #{get_page_title}"
    
    #@datasource_date = get_file_mod_date('public/data/mr-c-replies.csv')
    @datasource_date_pretty = '06.10.2012'
    
    erb :mr_correcter
  end

  # operation fortress map view
  # /op-fortress
  get '/op-fortress' do
    @page_title = "Mapping #operation fortress > #{get_page_title}"
    
    #@datasource_date = get_file_mod_date('public/data/op-fortress.csv')
    @datasource_date_pretty = '21.09.2013'
      
    erb :op_fortress
  end

  # Price of Football 2012 map view
  # /pof-2012
  get '/pof-2012' do
    @page_title = "BBC Price of Football 2012 mapped > #{get_page_title}"
    
    #@datasource_date = get_file_mod_date('public/data/pof-2012.json')
    @datasource_date_pretty = '22.10.2012'
      
    erb :pof_2012
  end

  # BBC cat study traces
  # /cat-traces
  get '/secret-life-of-the-cat' do
    @page_title = "Secret Life of the Cat > #{get_page_title}"
    
    #@datasource_date = get_file_mod_date('public/data/cats.json')
    @datasource_date_pretty = '02.07.2013'
      
    erb :cat_traces
  end

end