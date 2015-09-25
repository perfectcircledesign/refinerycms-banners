module ActsAsBannerable
  extend ActiveSupport::Concern
  module ClassMethods
    def acts_as_bannerable
      has_many :banners, :through => :bannerings, :as => :bannerable
      has_many :bannerings, as: :bannerable, dependent: :destroy, class_name: '::Refinery::Banners::Bannering'
    end
  end
end

::ActiveRecord::Base.send :include, ::ActsAsBannerable
