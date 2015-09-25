module BannerHelper
  def set_banner_limit(limit)
    if limit.present?
      limit
    else
      nil
    end
  end

  def set_banner_types(banner_types)
    if banner_types.present?
      banner_types
    else
      Refinery::Banners::Banner.included_banners(::Refinery::Banners::Banner::BANNER_TYPES)
    end
  end

  def render_banners(object, args ={})
    banners = []
    banner_type = args[:banner_types] || nil
    limit = args[:limit] || nil
    background = args[:background] || nil
    if object.present? and object.banners.published.present?
      object.banners.published.where(:banner_type => set_banner_types(banner_type)).limit(set_banner_limit(limit)).order(:position).each do |banner|
        if background.present? and background == true
          banners << banner.image.url
        else
          banners << (render :partial => "refinery/banners/shared/#{banner.system_title}_banner", :locals => {:banner => banner})
        end
      end
    end

    if background.present? and background == true
      if limit.present? and limit == 1
        banners[rand(banners.length)]
      else
        banners
      end
    else
      if limit.present? and limit == 1
        banners[rand(banners.length)].html_safe
      else
        banners.join.html_safe
      end
    end
  end

end
