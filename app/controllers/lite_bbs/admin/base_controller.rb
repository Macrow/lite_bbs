module LiteBbs
  module Admin
    class BaseController < ::LiteBbs::ApplicationController
      before_filter :authenticate_admin!
      
      def authenticate_admin!
        unless (litebbs_current_user and litebbs_current_user.admin?)
          flash[:error] = t('lite_bbs.msg.admin_only')
          redirect_to root_url
        end
      end
    end
  end
end
