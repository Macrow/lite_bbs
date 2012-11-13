require_dependency "lite_bbs/application_controller"

module LiteBbs
  class TopicsController < ApplicationController
    def show
      @topic = Topic.find(params[:id], include: :user)
      @replies = @topic.replies.includes(:user).page(params[:page])
      @topic.view_once      
      @reply = Reply.new
      @section_name = @topic.section.name
      @forum_name = @topic.forum.name
      @topic_title = @topic.title
      respond_with(@topic)
    end
  
    def edit
      @topic = Topic.find(params[:id])
      authorize! :edit, @topic
    end

    def create
      @forum = Forum.find(params[:forum_id])
      @topic = @forum.topics.build(params[:topic])
      authorize! :create, @topic
      @topic.section = @forum.section
      @topic.user = litebbs_current_user
      @topic.save
    end

    def update
      @topic = Topic.find(params[:id])
      authorize! :update, @topic
      @topic.update_attributes(params[:topic])
    end

    def destroy
      @topic = Topic.find(params[:id], include: :forum)
      authorize! :destroy, @topic
      forum = Forum.find(@topic.forum_id)
      @topic.destroy
      redirect_to forum
    end
    
    def toggle_stick
      @topic = Topic.find(params[:id])
      authorize! :manage, @topic
      @topic.toggle_stick
    end
    
    def toggle_can_reply
      @topic = Topic.find(params[:id])
      authorize! :manage, @topic
      @topic.toggle!(:can_reply)
    end
  end
end
