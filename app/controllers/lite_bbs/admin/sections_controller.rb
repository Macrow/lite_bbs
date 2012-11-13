module LiteBbs
  module Admin
    class SectionsController < BaseController
      def index
        @sections = Section.scoped.order(:orders)
      end
      
      def new
        @section = Section.new
      end
      
      def edit
        @section = Section.find(params[:id])
      end
      
      def create
        @section = Section.new(params[:section])
        if @section.save
          flash[:info] = t('lite_bbs.msg.create', model: Section.model_name.human)          
          redirect_to admin_sections_path
        else
          render 'new'
        end
      end
      
      def update
        @section = Section.find(params[:id])
        if @section.update_attributes(params[:section])
          flash[:info] = t('lite_bbs.msg.update', model: Section.model_name.human)          
          redirect_to admin_sections_path
        else
          render 'edit'
        end
      end
      
      def confirm_destroy
        @section = Section.find(params[:id])
      end
      
      def destroy
        @section = Section.find(params[:id])
        @section.destroy
        flash[:info] = t('lite_bbs.msg.destroy', model: Section.model_name.human)
        redirect_to admin_sections_path        
      end
      
      def order
        Section.update_orders(params[:section_ids], params[:section_orders])
        flash[:info] = t('lite_bbs.msg.order', model: Section.model_name.human)        
        redirect_to admin_sections_path
      end
    end
  end
end
