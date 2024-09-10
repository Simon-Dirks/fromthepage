Rails.application.configure do

  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local = true
  # config.action_controller.perform_caching = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  # if Rails.root.join('tmp', 'caching-dev.txt').exist?
  #   config.action_controller.perform_caching = true
  #   config.action_controller.enable_fragment_cache_logging = true
  #
  #   config.cache_store = :memory_store
  #   config.public_file_server.headers = {
  #     'Cache-Control' => "public, max-age=#{2.days.to_i}"
  #   }
  # else
  config.action_controller.perform_caching = false

  config.cache_store = :null_store
  # end

  config.public_file_server.enabled = true

  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  Rails.application.routes.default_url_options = config.action_mailer.default_url_options =  { host: 'localhost:3000' }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  # number of complex assets.
  config.assets.debug = true

  config.assets.quiet = false

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  Rails.application.routes.default_url_options[:host] = 'localhost:3000'

  config.active_record.dump_schema_after_migration = false
  config.action_mailer.default_url_options = { host: 'fromthepage.com' }
  config.action_mailer.default_options = { from: 'support@fromthepage.com' }
  config.action_mailer.delivery_method = :postmark

  config.action_mailer.postmark_settings = {
    api_token: ''
  }

  Ahoy.geocode = false
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache

  RAKE = '/usr/bin/env rake'
  NEATO = '/usr/bin/neato'
  TEX_PATH='/usr/local/texlive/2017/bin/x86_64-linux/'
  UPGRADE_FORM_LINK='https://app.bentonow.com/f/6247d0278bfbafc3ef75b753f26a46d2/red-tree-885/'
#  BILLING_HOST_DEVELOPMENT = 'billing.fromthepage.com'
#  Disable IIIF search while Pontiiif is down
#  config.pontiiif_server = 'http://pontiiif.brumfieldlabs.com/'

  config.i18n.fallbacks = true
  config.force_ssl = true

  config.pontiiif_server = 'http://pontiiif.brumfieldlabs.com/'

  ## Config for MailCatcher ##
  # Install mailcatcher locally on your machine 'gem install mailcatcher'
  # Run 'mailcatcher' in the terminal to start the server
  # Open 'http://localhost:1080/' in your browser to see mail sent
end
