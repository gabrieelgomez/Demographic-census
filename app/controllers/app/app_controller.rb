module App
  # AppController -> Controller out the back-office
  class AppController < ::ApplicationController
    layout 'app/layouts/application'
    before_filter :set_metas
    before_action :nav_category

    def set_metas
      @setting = Setting.first
      @title = @setting.name
      @description = @setting.description
      @favicon = @setting.favicon
      @meta = MetaTag.get_by_url(request.url)
      @google_adword = GoogleAdword.get_by_url(request.url)
    end

    private

    def nav_category
      @categories = FrontController::Category.all
    end
  end
end
