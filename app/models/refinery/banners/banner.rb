module Refinery
  module Banners
    class Banner < Refinery::Core::BaseModel
      self.table_name = 'refinery_banners'

      attr_accessible :banner_type, :title, :caption, :image_id, :start_date, :expiry_date, :video_id, :url, :position, :page_ids

      validates :banner_type, :presence => true

      BANNER_TYPES = %w(image video sliver)

      belongs_to :image, :class_name => '::Refinery::Image'
      belongs_to :video, :class_name => '::Refinery::Videos::Video'
      has_many :pages, :through => :bannerings, :source => :bannerable, :source_type => 'Refinery::Page'
      has_many :bannerings, :foreign_key => :banner_id

      scope :not_expired, lambda {
                          banners = Arel::Table.new(::Refinery::Banners::Banner.table_name)
                          where(banners[:expiry_date].eq(nil).or(banners[:expiry_date].gt(Time.now)))
                        }
      scope :published, lambda {
                        not_expired.where("start_date <= ?", Time.now).order(:position)
                      }


      def system_title
        banner_type
      end

      def self.included_banner_types(banner_types)
        unless defined?(::Refinery::Videos::Video)
          banner_types -= ['video']
        end
        banner_types
      end
    end
  end
end
