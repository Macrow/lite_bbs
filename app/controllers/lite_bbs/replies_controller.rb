require_dependency "lite_bbs/application_controller"

module LiteBbs
  class RepliesController < ApplicationController
    def create
      @topic = Topic.find(params[:topic_id])      
      @reply = @topic.replies.build(params[:reply])
      authorize! :create, @reply
      @reply.forum = @topic.forum
      @reply.user = litebbs_current_user
      @reply.floor = @topic.floor_count + 1
      @reply.save
    end
    
    def edit
      @reply = Reply.find(params[:id])
      authorize! :edit, @reply
    end
  
    def update
      @reply = Reply.find(params[:id])
      authorize! :update, @reply      
      @reply.update_attributes(params[:reply])
    end
  
    def destroy
      @reply = Reply.find(params[:id])
      authorize! :destroy, @reply
      @reply.destroy
    end
  end
end
