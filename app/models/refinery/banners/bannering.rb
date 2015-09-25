module Refinery
  module Banners
    class Bannering < Refinery::Core::BaseModel
      self.table_name = 'refinery_bannerings'

      attr_accessible :banner_id, :bannerable_id, :bannerable_type

      belongs_to :banner, class_name: '::Refinery::Banners::Banner'
      belongs_to :bannerable, class_name: '::Refinery::Banners::Bannering', :polymorphic => true

    end
  end
end
