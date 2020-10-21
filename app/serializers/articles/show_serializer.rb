class Articles::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :content, :category, :premium, :image

  def content
    object.premium && (current_user.nil? || current_user.role == "user") ? object.content[0..299] : object.content
  end

  def image
    return nil unless object.image.attached?
    if Rails.env.test?
      rails_blob_url(object.image)
    else
      return object.image.service_url
    end
  end
end
