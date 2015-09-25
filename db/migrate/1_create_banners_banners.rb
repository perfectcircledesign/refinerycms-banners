class CreateBannersBanners < ActiveRecord::Migration

  def up
    create_table :refinery_banners do |t|
      t.string :banner_type
      t.string :title
      t.string :caption
      t.integer :image_id
      t.date :start_date
      t.integer :video_id
      t.string :url
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-banners"})
    end

    drop_table :refinery_banners

  end

end
