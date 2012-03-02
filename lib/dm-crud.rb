require 'active_support'
require 'action_controller'
#require 'will_paginate'
#require 'meta_search'

require 'dm-crud/hook_methods'
require 'dm-crud/class_methods'
require 'dm-crud/base'

module Crud
  class Engine < Rails::Engine
  end
end

ActionController::Base.send(:include, Crud::Base)