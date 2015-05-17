# Require some basics
# %w(rubygems sinatra active_record erb lib/models.rb lib/helpers.rb).each do |lib|
# require lib
# end

# require 'rubygems'
# require 'sinatra/base'
# require 'sinatra/asset_pipeline'
# require 'haml'
# require 'bootstrap-sass'

require 'bundler'
Bundler.require

class Cheetah < Sinatra::Base
  set :root,          File.dirname(__FILE__)
  set :assets,        Sprockets::Environment.new(root)
  set :precompile,    [ /\w+\.(?!js|css).+/, /application.(css|js)$/ ]
  set :assets_prefix, '/assets'
  set :digest_assets, false
  set(:assets_path)   { File.join public_folder, assets_prefix }

  configure do
    # Setup Sprockets
    %w{js css img}.each do |type|
      assets.append_path "assets/#{type}"
      # assets.append_path Compass::Frameworks['bootstrap'].templates_directory + "/../vendor/assets/#{type}"
    end
    assets.append_path 'assets/fonts'

    # Configure Sprockets::Helpers (if necessary)
    Sprockets::Helpers.configure do |config|
      config.environment = assets
      config.prefix      = assets_prefix
      config.digest      = digest_assets
      config.public_path = public_folder
    end
    Sprockets::Sass.add_sass_functions = false

    set :haml, { :format => :html5 }
  end

  helpers do
    include Sprockets::Helpers
  end

  get '/' do
    haml :index
    # return 'It works!'
  end
end
