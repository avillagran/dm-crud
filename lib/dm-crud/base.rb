# encoding: utf-8
module Crud

  module Base
  
    def self.default_options(model_name)
      singular_name = model_name.to_s
      class_name = singular_name.camelize
      plural_name = singular_name.pluralize
      this_class = class_name.constantize
      {
        :title_attribute => "title",
        :use_class_name_as_title => false,
        :list => true,
        :paginate => true,
        :sortable => false,
        :searchable => true,
        :conditions => '',
        :search_conditions => '',
        :redirect_to_url => "admin_#{plural_name}_url",
        :log => Rails.env == 'development'
      }
    end
  
    def self.append_features(base)
      super
      base.send(:include, Crud::HookMethods)
      base.extend(Crud::ClassMethods)
    end
  
  end

end
