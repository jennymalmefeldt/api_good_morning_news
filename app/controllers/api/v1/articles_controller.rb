# frozen_string_literal: true

class Api::V1::ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_active_record_error
  before_action :check_valid_category, only: :index, if: :searching_for_categoriezed_content

  def index
    articles = if searching_for_categoriezed_content
                 Article.where(category: params['category'])
               else
                 Article.all
               end
    render json: articles, each_serializer: ArticlesIndexSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article, serializer: ArticleShowSerializer
  end

  private

  def render_active_record_error
    render json: { error_message: 'Sorry we can not find that article' }, status: :not_found
  end

  def check_valid_category
    render json: { error_message: 'Sorry, we can\'t find that category' }, status: :not_found unless Article.categories.keys.include?(params['category'])
  end

  def searching_for_categoriezed_content
    !params['category'].nil?
  end
end
