require 'rails/generators'

module Crud
    class ScaffoldGenerator < Rails::Generators::NamedBase
        source_root File.expand_path('../templates', __FILE__)

        argument :create, type: :string, default: "all", :banner => "model-controller or model-views or views-controller or all"

        argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

        

        class_option :timestamps, :type => :boolean
        class_option :parent,     :type => :string, :desc => "The parent class for the generated model"


        def scaffold
            check_class_collision if create.include?('model')

            template 'model.rb', "app/models/#{file_name}.rb" if create.include?('model') or create.include?('all')
            template 'controller.rb', "app/controllers/#{plural_file_name}_controller.rb" if create.include?('controller') or create.include?('all')

            if create.include?('view') or create.include?('all')
                template "index.haml", "app/views/#{plural_file_name}/index.haml"
                template "show.haml", "app/views/#{plural_file_name}/show.haml"
                template "new.haml", "app/views/#{plural_file_name}/new.haml"
                template "edit.haml", "app/views/#{plural_file_name}/edit.haml"
                template "_form.haml", "app/views/#{plural_file_name}/_form.haml"
            end


        end

        protected
        def typeclass(attrib)
            return 'DateTime' if attrib.type.to_s == 'datetime'
            return attrib.type.to_s.camelcase
        end
    end
end
