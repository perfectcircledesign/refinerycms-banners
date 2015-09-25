module Refinery
  module Banners
    module Admin
      class BannersController < ::Refinery::AdminController

        crudify :'refinery/banners/banner',
                :title_attribute => 'banner_type',
                :xhr_paging => true

      end
    end
  end
end
