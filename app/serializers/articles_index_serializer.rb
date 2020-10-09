class ArticlesIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :category
end
