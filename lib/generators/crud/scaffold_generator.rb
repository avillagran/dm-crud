require 'rails/generators'

module Crud
    class ScaffoldGenerator < Rails::Generators::NamedBase
        source_root File.expand_path('../templates', __FILE__)

        argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

        check_class_collision

        class_option :timestamps, :type => :boolean
        class_option :parent,     :type => :string, :desc => "The parent class for the generated model"


        def scaffold
            template 'model.rb', "app/models/#{file_name}.rb"
            template 'controller.rb', "app/controllers/#{plural_file_name}_controller.rb"

            template "index.haml", "app/views/#{plural_file_name}/index.haml"
            template "show.haml", "app/views/#{plural_file_name}/show.haml"
            template "new.haml", "app/views/#{plural_file_name}/new.haml"
            template "edit.haml", "app/views/#{plural_file_name}/edit.haml"
            template "_form.haml", "app/views/#{plural_file_name}/_form.haml"


        end

        protected
        def typeclass(attrib)
            return 'DateTime' if attrib.type.to_s == 'datetime'
            return attrib.type.to_s.camelcase
        end
    end
end
