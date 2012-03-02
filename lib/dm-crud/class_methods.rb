#
# Disclaimer:
#
# The majority of this was originally written by 
# the splendid fellows at Resolve Digital for their
# awesome refinerycms project.
#

module Crud

    module ClassMethods

        def crud(model_name, options = {})

            options = ::Crud::Base.default_options(model_name).merge(options)

            singular_name = model_name.to_s
            class_name = singular_name.camelize
            plural_name = singular_name.pluralize

            options[:paginate] = (options[:paginate] && eval(class_name).respond_to?(:paginate))

            module_eval %(    
              
              def index
                @items = #{class_name}.all if #{options[:list]}
              end

              def show
              end

              def new
                @item = #{class_name}.new
              end

              def create
              
                @item = #{class_name}.new(params[:#{singular_name}])
                
                ok = before_create
                return ok unless ok === true

                if @item.valid? && @item.save  
                  successful_create
                else
                  failed_create
                end
              end

              def edit
                @item = #{class_name}.get params[:id]
              end

              def update
                ok = before_update
                return ok unless ok === true    

                if @item.update(params[:#{singular_name}])
                  successful_update              
                else
                  failed_update
                end
              end

              def destroy
                ok = before_destroy
                return ok unless ok === true
                
                if @item.destroy
                  successful_destroy
                else
                  failed_destroy
                end
              end

              def set_what
               return @what if @what
               what = @crud_options[:use_class_name_as_title] ? @item.class.to_s.underscore.humanize : @item.send(@crud_options[:title_attribute].to_sym).inspect
               what = @item.class.to_s.underscore.humanize if what.nil? || what == '""'
               @what = what
              end

              def find_item
                @item = #{class_name}.get params[:id]
              end

              def set_crud_options
                @crud_options = #{options.inspect}
              end

              prepend_before_filter :find_item, :only => [:show, :update, :destroy]
              prepend_before_filter :set_crud_options

              protected :find_item, :set_crud_options
            )
        end

    end

end