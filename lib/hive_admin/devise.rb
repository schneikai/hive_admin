# We need to make sure that our controller extensions are added after Devise
# has added its *current_user* helper. This is done by Devise via the *devise_for*
# call in the host apps route file and I found no obvious way of executing code
# after when *devise_for* has finished. So we alias the method with which Devise
# is adding its helpers and adding ours after.

require 'devise'

module Devise
  module Controllers
    module Helpers
      class << self
        alias :old_define_helpers :define_helpers
      end

      def self.define_helpers(mapping) #:nodoc:
        old_define_helpers(mapping)
        ActiveSupport.on_load(:action_controller) { include HiveAdmin::Controller }
      end
    end
  end
end
