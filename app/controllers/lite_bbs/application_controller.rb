require 'cancan'
require 'ransack'
require 'mobylette'

module LiteBbs
  class ApplicationController < ActionController::Base
    include ::Mobylette::RespondToMobileRequests
    layout LiteBbs.layout_name
    respond_to :html, :mobile, :js
    ERROR_MESSAGE = ' Please configure your config/initializers/lite_bbs.rb for right methods name.'
    before_filter :initialize_search
    helper_method :section_name, :forum_name, :topic_title
    
    def section_name; @section_name ||= ''; end
    def forum_name; @forum_name ||= ''; end
    def topic_title; @topic_title ||= ''; end
    
    rescue_from ::CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end
    
    def current_ability
      @current_ability ||= LiteBbs::Ability.new(litebbs_current_user)
    end
    
    LiteBbs.litebbs_helper_methods.each do |key, method|
      method_name = "litebbs_#{key}"
      define_method(method_name) do
        catch_error do
          return send(method)
        end
      end
      helper_method method_name
    end
    LiteBbs.litebbs_user_helper_methods.each do |key, method|
      method_name = "litebbs_user_#{key}"
      define_method(method_name) do |user|        
        if user.nil?
          return LiteBbs.litebbs_user_helper_methods_default_result[key]
        else
          catch_error do
            return (user.send(method) || LiteBbs.litebbs_user_helper_methods_default_result[key])
          end
        end
      end
      helper_method method_name
    end

    private
    def catch_error(&blk)
      begin
        yield
      rescue NoMethodError => e
        e.message << ERROR_MESSAGE
        raise e
      end
    end
    
    def initialize_search
      @q = Topic.search(params[:q])
    end
  end
end
