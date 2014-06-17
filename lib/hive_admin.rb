require 'hive_admin/devise'

module HiveAdmin
  autoload :Controller, 'hive_admin/controller'
  autoload :Impersonator, 'hive_admin/impersonator'
  autoload :BasicAuthorizationAdapter, 'hive_admin/basic_authorization_adapter'
  autoload :CanCanAuthorizationAdapter, 'hive_admin/cancan_authorization_adapter'
  autoload :Model, 'hive_admin/model'

  # Allows to configure HiveAdmin and ActiveAdmin via a initializer in the host app.
  #
  #   HiveAdmin.setup do |config|
  #     config.site_title = "My Administration"
  #   end
  #
  def self.setup(&block)
    # First send the block to self (HiveAdmin) to set HiveAdmin related configurations.
    # We rescue from *NoMethodError* here if a ActiveAdmin configuration method is called.
    begin
      yield self
    rescue NoMethodError
      # Do nothing
    end

    # Now call <tt>ActiveAdmin.setup</tt> with the given block to configure and
    # initialize ActiveAdmin. It is really important that this is happening only
    # once because <tt>ActiveAdmin.setup</tt> will attach reloaders and stuff
    # that would get executed twice if *setup* is called twice!
    # Because we also need to configure some settings for ActiveAdmin we added
    # the method *configure_aa* that just sets the configurations but does not
    # initialize ActiveAdmin.
    ActiveAdmin.setup &block
  end

  # Allows to set configurations for ActiveAdmin without initializing it.
  # This mostly used internally by HiveAdmin to preconfigure ActiveAdmin.
  def self.configure_aa
    yield(ActiveAdmin.application)
  end
end

require 'hive_admin/engine'
