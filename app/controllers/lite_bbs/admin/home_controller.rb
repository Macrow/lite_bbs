module LiteBbs
  module Admin
    class HomeController < BaseController
      def index
        @names = %W{Section Forum Topic Reply}
        @counts = []
        @names.each { |name| @counts << "LiteBbs::#{name}".constantize.count }
      end
    end
  end
end
