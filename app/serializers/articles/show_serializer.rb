class Articles::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :content, :category, :premium

  def content
    object.premium ? object.content[0...100] : object.content
  end
end
