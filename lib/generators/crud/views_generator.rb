require 'rails/generators'

module Crud
    class ViewsGenerator < Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        argument :model_name, type: :string

        def views

            template "index.haml", "app/views/#{model.singularize}/index.haml"
            template "show.haml", "app/views/#{model.singularize}/show.haml"
            template "new.haml", "app/views/#{model.singularize}/new.haml"
            template "edit.haml", "app/views/#{model.singularize}/edit.haml"
            template "_form.haml", "app/views/#{model.singularize}/_form.haml"

        end

        private
        def model
            model_name.underscore
        end
    end
end