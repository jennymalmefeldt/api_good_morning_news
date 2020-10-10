class Api::V1::ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_active_record_error

  def index
    if params['category']
      articles = Article.where(category: params['category'])
    else
      articles = Article.all
    end
    render json: articles, each_serializer: ArticlesIndexSerializer
  rescue
    render json: { error_message: "Sorry we can not find that article" }, status: :not_found
  end

  def show
    article = Article.find(params[:id])
    render json: article, serializer: ArticleShowSerializer
  end

  private

  def render_active_record_error
    render json: { error_message: 'Sorry we can not find that article' }, status: :not_found
  end
end
