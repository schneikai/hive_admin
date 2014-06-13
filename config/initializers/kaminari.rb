# https://github.com/gregbell/active_admin/blob/ce996c450beb32b8378148b133ebef7d140635bb/docs/0-installation.md#will_paginate-compatibility
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end
