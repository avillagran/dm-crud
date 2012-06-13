# encoding: utf-8
module Crud

  module HookMethods
    
    private
      
      def before_create
        # just a hook!
        logger.info "> Crud::before_create" if @crud_options[:log]
        before_action
      end    
        
      def before_update
        # just a hook!
        logger.info "> Crud::before_update" if @crud_options[:log]
        before_action
      end    
        
      def before_destroy
        # just a hook!
        logger.info "> Crud::before_destroy" if @crud_options[:log]
        before_action
      end
            
      def before_action
        # just a hook!
        logger.info "> Crud::before_action" if @crud_options[:log]
        true
      end
      
              
      
      def successful_create
        logger.info "> Crud::successful_create" if @crud_options[:log]

        flash[:notice] = t('crud.created', :what => set_what)
        successful_action
        after_success
      end
      
      def successful_update
        logger.info "> Crud::successful_update" if @crud_options[:log]
        
        flash[:notice] = t('crud.updated', :what => set_what)
        successful_action

        after_success
      end
      
      def successful_destroy
        logger.info "> Crud::successful_destroy" if @crud_options[:log]
        flash.notice = t('crud.destroyed', :what => @what)        

        successful_action_destroy

        after_success
      end

      def successful_action
        logger.info "> Crud::successful_action" if @crud_options[:log]
      end
      
      def successful_action_destroy
        logger.info "> Crud::successful_action_destroy" if @crud_options[:log]
      end

      def after_success
        logger.info "> Crud::after_success" if @crud_options[:log]
        
        unless request.xhr?
          if @redirect_to_url
            redirect_to @redirect_to_url
          elsif params[:commit].to_s.match(/continue/)
            if params[:action] == 'create'
              url =  request.referer.sub(/(\/?(new)?\/?)$/, '') + "/#{@item.to_param}"
              url += "/edit" if params[:commit].to_s.match(/edit/)
            else
              url = request.referer
            end    
            redirect_to url        
          else
            if defined?(redirect_back_or_default)
              redirect_back_or_default url
            else
              redirect_to eval(@crud_options[:redirect_to_url])
            end
          end
        else
          render :partial => "/shared/message"
        end
        
      end
      
      
      
      
      def failed_create
        logger.info "> Crud::failed_create" if @crud_options[:log]
        flash[:error] = t('crud.failed_create', :what => set_what)
        after_fail
      end
      
      def failed_update
        logger.info "> Crud::failed_update" if @crud_options[:log]
        flash[:error] = t('crud.failed_update', :what => set_what)
        after_fail
      end
      
      def failed_destroy
        logger.info "> Crud::failed_destroy" if @crud_options[:log]
        flash[:error] = t('crud.failed_destroy', :what => @what)
        after_fail
      end
      
      def after_fail
        logger.info "> Crud::after_fail errors: #{@item.errors.inspect}" if @crud_options[:log]
        
        unless request.xhr?
          render :action => request.post? ? 'new' : 'edit'
        else          
          flash[:error] = [flash[:error], @item.errors.collect{|key,value| "#{key} #{value}"}.join("<br/>")]
          render :partial => "/shared/message"
        end
      end
      
  
    end

end
