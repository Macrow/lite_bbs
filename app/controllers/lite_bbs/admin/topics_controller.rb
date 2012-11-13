require 'ransack'

module LiteBbs
  module Admin
    class TopicsController < BaseController
      def index
        @q = Topic.search(params[:q])
        @topics = @q.result(distinct: true).includes(:forum, :user).order('id DESC').page(params[:page])
        @topics = @topics.stick if params[:stick] == 'true'
        @topics = @topics.seal if params[:seal] == 'true'
        @sections = Section.all
      end
      
      def new
        @sections = Section.all
        @topic = Topic.new
      end
      
      def edit
        @sections = Section.all
        @topic = Topic.find(params[:id])
      end
      
      def create
        @sections = Section.all
        @topic = Topic.new(params[:topic])
        @topic.forum = Forum.find(params[:topic][:forum_id])        
        @topic.section = @topic.forum.section
        @topic.user = litebbs_current_user        
        if @topic.save
          flash[:info] = t('lite_bbs.msg.create', model: Topic.model_name.human)          
          redirect_to admin_topics_path
        else
          render 'new'
        end
      end
      
      def update
        @sections = Section.all
        @topic = Topic.find(params[:id])
        @topic.forum = Forum.find(params[:topic][:forum_id])
        @topic.section = @topic.forum.section
        if @topic.update_attributes(params[:topic])
          flash[:info] = t('lite_bbs.msg.update', model: Topic.model_name.human)          
          redirect_to admin_topics_path
        else
          render 'edit'
        end
      end
      
      def destroy
        @topic = Topic.find(params[:id])
        @topic.destroy
        flash[:info] = t('lite_bbs.msg.destroy', model: Topic.model_name.human)        
        redirect_to admin_topics_path
      end
    end
  end
end
