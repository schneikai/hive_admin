$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hive_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hive_admin"
  s.version     = HiveAdmin::VERSION
  s.authors     = ["Kai Schneider"]
  s.email       = ["schneikai@gmail.com"]
  s.homepage    = "https://github.com/schneikai/hive_admin"
  s.summary     = "User administration for Hive."
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "hive"#, "~> 4.0.5"
  s.add_dependency "activeadmin"#, "~> 4.0.5"

  # Need this because of bootstrap-sass bug
  # http://stackoverflow.com/questions/22426698/undefined-method-environment-for-nilnilclass-when-importing-bootstrap-into-ra
  s.add_dependency "sass-rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "jquery-rails"
  s.add_development_dependency "thin"
  s.add_development_dependency "quiet_assets"
end
