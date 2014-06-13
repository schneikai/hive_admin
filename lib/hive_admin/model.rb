# Extensions for the Hive user model.

module HiveAdmin
  module Model
    extend ActiveSupport::Concern

    included do
      # ActiveAdmins Formtastic needs this to add/edit roles for users.
      # http://stackoverflow.com/questions/7206541/activeadmin-with-has-many-problem-undefined-method-new-record
      accepts_nested_attributes_for :rolez, allow_destroy: true
    end
  end
end
