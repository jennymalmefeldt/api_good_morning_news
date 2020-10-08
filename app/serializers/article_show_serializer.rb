class ArticleShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :content
end
