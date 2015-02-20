Rails.application.routes.draw do
  # TODO KS: Had to remove this and move to host app. If you have a catch-all
  # route in host app and because Gem routes are loaded after host app this
  # routes here would never get hit.
  # ActiveAdmin.routes(self)
end
