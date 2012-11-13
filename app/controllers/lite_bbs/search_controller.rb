require_dependency "lite_bbs/application_controller"

module LiteBbs
  class SearchController < ApplicationController
    def index
      if params[:q][:title_cont] != ''
        @good_search = true
        @topics = @q.result(distinct: true).includes(:user, :last_reply => :user).page(params[:page])
      else
        @good_search = false
      end
      respond_with(@topics)
    end
    
    def advance
    end
  end
end
