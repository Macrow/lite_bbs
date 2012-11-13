module LiteBbs
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
    desc "Install LiteBBS for your application."
  
    def copy_initializer_file
      copy_file "initializer.rb", "config/initializers/lite_bbs.rb"
    end
    
    def copy_layout_files
      copy_file "layout.html.erb", "app/views/layouts/lite_layout.html.erb"
    end

    def copy_migration_files
      migration_template "migration.rb", "db/migrate/create_lite_bbs_tables.rb"
    end
    
    def insert_routes_config
      route("mount LiteBbs::Engine => '/bbs', as: 'litebbs_engine'")
    end
    
    def insert_js_and_css_require
      if File.exist?('app/assets/javascripts/application.js')
        insert_into_file "app/assets/javascripts/application.js", "//= require lite_bbs/core\n", :after => "jquery_ujs\n"
      else
        copy_file "application.js", "app/assets/javascripts/application.js"
      end
      if File.exist?('app/assets/stylesheets/application.css')
        insert_into_file "app/assets/stylesheets/application.css", " *= require lite_bbs/core\n", :after => "require_self\n"
      else
        copy_file "application.css", "app/assets/stylesheets/application.css"
      end
    end
    
    def insert_routes
      route("mount LiteBbs::Engine => '/bbs', as: 'litebbs_engine'")
    end
    
    def show_readme
      readme("README")
    end

    def self.next_migration_number(dirname)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end
  end
end
