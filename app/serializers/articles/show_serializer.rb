class Articles::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :content, :category
end
