class Articles::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :category
end
