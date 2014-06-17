module HiveAdmin
  class Engine < ::Rails::Engine
    config.to_prepare do
      ::User.send :include, HiveAdmin::Model
    end

    # TODO: This is not in the initializer.
    # # ActiveAdmin resources are defined in *lib/hive_admin/admin* to allow the
    # # host app to define or overwrite resources in the default location *app/admin*
    # # and to fix a bug in ActiveAdmin where it breaks when engine files are in
    # # the eager load path. See https://github.com/gregbell/active_admin/wiki/Define-a-resource-inside-an-engine
    # initializer :my_engine do
    #   # ActiveAdmin.application.load_paths << File.expand_path("../admin", __FILE__)
    #   # ActiveAdmin.application.load_paths.unshift File.expand_path("../admin", __FILE__)

    #   puts "!!! load paths: #{ActiveAdmin.application.load_paths}"
    # end
  end
end
