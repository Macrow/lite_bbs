module LiteBbs
  module Admin
    class ForumsController < BaseController
      def index
        @sections = Section.scoped.includes(:forums)
      end
      
      def new
        @forum = Forum.new
      end
      
      def edit
        @forum = Forum.find(params[:id])
      end
      
      def create
        @forum = Forum.new(params[:forum])
        if @forum.save
          flash[:info] = t('lite_bbs.msg.create', model: Forum.model_name.human)
          redirect_to admin_forums_path
        else
          render 'new'
        end
      end
      
      def update
        @forum = Forum.find(params[:id])
        if @forum.update_attributes(params[:forum])
          flash[:info] = t('lite_bbs.msg.update', model: Forum.model_name.human)          
          redirect_to admin_forums_path
        else
          render 'edit'
        end
      end
      
      def confirm_destroy
        @forum = Forum.find(params[:id])
      end
      
      def destroy
        @forum = Forum.find(params[:id])
        @forum.destroy
        flash[:info] = t('lite_bbs.msg.destroy', model: Forum.model_name.human)        
        redirect_to admin_forums_path
      end
      
      def order
        Forum.update_orders(params[:forum_ids], params[:forum_orders])
        flash[:info] = t('lite_bbs.msg.order', model: Forum.model_name.human)        
        redirect_to admin_forums_path
      end
    end
  end
end
