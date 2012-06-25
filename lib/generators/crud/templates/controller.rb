class <%= class_name.pluralize %>Controller < ApplicationController
    before_filter :store_location, :only => :index

    crud :<%= file_name %>, :use_class_name_as_title => true
end