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
checkout HiveAdmin.


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


## TODO
* add lock/unlock actions
* Have to check how assets are included when the engine is loaded inside an app
  we also need to have styles and js configurable from the host app.
  http://mrdanadams.com/2011/exclude-active-admin-js-css-rails/#.U5hK741_tDs
* must check Hive if user is deletable
* use devise_attributable to get the editable fields for the form


## Licence

MIT-LICENSE. Copyright 2014 Kai Schneider.
