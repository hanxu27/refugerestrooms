require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SaferstallsRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    if $next_rails
      config.load_defaults 6.0
      config.autoloader = :zeitwerk
    else
      config.load_defaults 5.2
      config.autoloader = :classic
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "/api/*", headers: :any, methods: [:get, :post, :options]
      end
    end

    # I18n stuff
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :es, :fil, :fr, :hi, :it, :pl, :"pt-BR", :tl]
    config.i18n.default_locale = :en



  end
end
