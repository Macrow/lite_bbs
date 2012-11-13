require_dependency "lite_bbs/application_controller"

module LiteBbs
  class ForumsController < ApplicationController
    def show
      @forum = Forum.find(params[:id])
      @stick_topics = @forum.stick_topics.includes([:last_reply => :user], :user)
      @topics = @forum.normal_topics.includes([:last_reply => :user], :user).page(params[:page])
      @topic = Topic.new
      @section_name = @forum.section.name
      @forum_name = @forum.name
      respond_with(@forum)
    end
  end
end
