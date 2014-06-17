# HiveAdmin


HiveAdmin is the user administration interface for [Hive](https://github.com/schneikai/hive).
It uses [ActiveAdmin](https://github.com/gregbell/active_admin) to
administrate Hives user model. It's setup to display the list of all users,
search and filter users, to edit and delete individual users and to login
(aka impersonate) as another user.


TODO: Add Screenshot!


## Installation

Add HiveAdmin to your Gemfile and run the bundle command to install it:

```ruby
gem 'hive_admin'
```

For now this must be added to the Gemfile of the Rails App that uses Hive:

```ruby
gem 'hive', github: 'schneikai/hive'
gem 'simple_form', github: 'plataformatec/simple_form'
gem 'devise_avatarable', github: 'schneikai/devise_avatarable'
gem 'devise_authorizable', github: 'schneikai/devise_authorizable'
gem 'devise_easy_omniauthable', github: 'schneikai/devise_easy_omniauthable'
gem 'devise_attributable', github: 'schneikai/devise_attributable'
gem 'activeadmin', github: 'gregbell/active_admin'
```

Run the *bundle* command to install it:

```console
bundle install
```

After the gem is installed you need to run the HiveAdmin install generator:

```console
rails generate hive_admin:install
```

When you are ready, migrate your database:

```console
rake db:migrate
```

You can now start your webserver and go to http://localhost:3000/admin to
checkout HiveAdmin. If you get a "access denied" message make sure you are logged
in and your user account has the *admin* role. If not you can assign this role
via the Rails console. For example if your account has the user id 1 type:

```console
User.find(1).add_role :admin
```


## Customization

You can easily customize HiveAdmin by creating a file in your app under
<tt>app/admin/user.rb</tt> and adding or overwriting functionality. For example
if you want to customize the index page with the list of users to just show the
user id, user name and actions to show details, edit and delete you could add
the following to <tt>app/admin/user.rb</tt>:

```ruby
ActiveAdmin.register User do
  index do
    id_column
    column :username
    actions
  end
end
```

The index page we use is a bit more interesting of course so you should checkout
our files under [<tt>lib/hive_admin/admin/user</tt>](https://github.com/schneikai/hive_admin/tree/master/lib/hive_admin/admin/user) in this Gem. If you want to get
a bigger picture don't forget to checkout [ActiveAdmins documentation](http://www.activeadmin.info/documentation.html) too.


## Security

HiveAdmin is setup to use Hives role based [authentication and authorization](https://github.com/schneikai/devise_authorizable) system.

Only users with the *admin* user role are allowed to access HiveAdmin and create,
read, update and destroy users.

If you have just installed Hive and HiveAdmin you need to assign this role
to the user you want to allow access to the admin area. You can do this via
the Rails console for example:

```console
User.find(1).add_role :admin
```

### Advanced Authorization

If you need a finer control of what users can do in HiveAdmin you might
want to remove the simple check for the *admin* role and instead define abilities.

To use the advanced authorization (aka CanCan authorization) make the following
changes to the HiveAdmin initializer in <tt>config/initializers/hive_admin.rb</tt>:

```ruby
config.authorization_adapter = HiveAdmin::CanCanAuthorizationAdapter
config.cancan_ability_class = "UserAbility"
```

Now you can define abilities in <tt>app/models/user_ability.rb</tt>.
For example imagine you have a *User* and a *Photo* model in your App and you
want some of your staff users to be able to manage just users, some others to
manage just photos and some staff users should be allowed to manage everything
the abilities could look like this:

```ruby
class UserAbility < DeviseAuthorizable::Ability

  ...

  def photo_admin
    can :manage, Photo
  end

  def user_admin
    can :manage, User

    # Don't allow regular user admins to assign roles to users or they could
    # assign the admin role to themselves.
    cannot :admin_rolify, User
  end

  def admin
    can :manage, :all
  end
end
```

Now you can assign the *photo_admin* role to your staff users who should be
allowed to manage photos, the *user_admin* role to user admins and the *admin*
role to your super admins.

Notice the <tt>cannot :admin_rolify, User</tt> in the *user_admin* block.
Besides what's already mentioned in the comment there is another important
thing here to notice. The action is called *admin_rolify*. Every action that
is executed in the admin area is prefixed with *admin* (ActiveAdmins default namespace).
So instead of just *:read, :create, :update, and :destroy* it is
*:admin_read, :admin_create, :admin_update, and :admin_destroy*. This is
important so you can distinguish between regular frontend actions and actions
in the admin area.

Be careful with the *manage* action because it is a alias that means
every action and that includes the regular actions as well as the admin actions.
So a user with the ability <tt>can :manage, User</tt> can
*:read, :create, :update, :destroy* as well as
*:admin_read, :admin_create, :admin_update, :admin_destroy* users.

So for the above example a alternative way of saying <tt>can :manage, Photo</tt>
would be:

```ruby
def user_admin
  can [:create, :read, :update, :destroy], User
  can [:admin_create, :admin_read, :admin_update, :admin_destroy], User
end
```



## TODO
* add lock/unlock actions
* Have to check how assets are included when the engine is loaded inside an app
  we also need to have styles and js configurable from the host app.
  http://mrdanadams.com/2011/exclude-active-admin-js-css-rails/#.U5hK741_tDs
* must check Hive if user is deletable
* use devise_attributable to get the editable fields for the form
* adding/removing roles to users is not properly authorized. it is just hidden
  if it is not allowed for the current user (form.rb authorized?(:rolify, user)).
  maybe move adding/deleting roles to a a member action so we can let AA do the authorization.

## Licence

MIT-LICENSE. Copyright 2014 Kai Schneider.
