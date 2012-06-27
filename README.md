DataMapper Crud
=======

A dynamic resource controller for Rails 3 and DataMapper

Based on [Crudify](http://raw.github.com/citrus/crudify)


Installation
------------

Add dm-crud to Gemfile:

    # Gemfile
    source "http://rubygems.org"
    gem 'rails',   '>= 3.0.0'        
    gem 'dm-crud', '0.0.3', git: 'http://github.com/avillagran/dm-crud'

Run:

    bundle install
    

Usage
-----

####  New!!! Use scaffold!

Generate model, controller and views:

    rails g crud:scaffold model all param1:string param2:string

Controller and views:

    rails g crud:scaffold product controller-view name:string stock:integer

Only model:

    rails g crud:scaffold product model name:string stock:integer

#### Old way:

Simply put `crud` on your controller:

    class JelliesController < ApplicationController
      crud :jelly
    end
    
    
This puts the basic functions on your controller INDEX, NEW, CREATE, EDIT, UPDATE and DELETE.
You can override this functions:

    class JelliesController < ApplicationController
      crudify :jelly
      
      def create     
        @jelly = Jelly.new(params[:jelly])
        # code
      end
    end
    



### Hook Methods

If you want do some operations before CREATE, UPDATE or DESTROY you must define this `before_create`, `before_update` or `before_destroy` like:

      def before_create    
        logger.info 'Put your code here!!'
        @item.all # You can access to the record with @item
      end

TODO
----
- Pagination and search
- Tests
- Documentation!