class Articles::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :content, :category, :premium

  def content
    object.premium && (current_user.nil? || current_user.role == "user") ? object.content[0..299] : object.content
  end
end
