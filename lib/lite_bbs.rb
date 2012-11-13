require "lite_bbs/engine"
require 'lite_bbs/core_ext'
require 'lite_bbs/version'
require 'bootstrap-sass'
require 'compass-rails'
require 'rails_kindeditor'
require 'simple_form'
require 'will_paginate'

module LiteBbs
  # Variables
  has_config :nil_string, default: 'N/A'
  has_config :user_image, default: 'user.gif'

  # Configration
  has_config :site_name, default: 'Lite'
  has_config :show_site_path, default: false
  has_config :bbs_name, default: 'LiteBBS'
  has_config :topics_per_page, default: 10
  has_config :replies_per_page, default: 10
  has_config :layout_name, default: 'lite_layout'
  has_config :display_flash_message, default: false
  has_config :user_class, default: 'User'
  
  # Methods
  has_helper_method :current_user # litebbs_current_user
  has_user_method :admin?, default_result: false      # -> litebbs_user_admin?(user)
  has_user_method :name, default_result: 'N/A'        # -> litebbs_user_name(user)
  has_user_method :email, default_result: 'N/A'       # -> litebbs_user_email(user)
  has_user_method :image, default_result: 'lite_bbs/user.gif'  # -> litebbs_user_image(user)
  
  class << self
    def config
      yield self
    end
    
    def root
      @root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end    
  end
end
