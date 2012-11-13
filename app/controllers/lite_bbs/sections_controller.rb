require_dependency "lite_bbs/application_controller"

module LiteBbs
  class SectionsController < ApplicationController
    def index
      @sections = Section.includes(:forums => [:last_topic => :user])
      respond_with(@sections)
    end

    def show
      @section = Section.find(params[:id], include: [:forums => [:last_topic => :user]])
      @section_name = @section.name
      respond_with(@section)
    end
  end
end
