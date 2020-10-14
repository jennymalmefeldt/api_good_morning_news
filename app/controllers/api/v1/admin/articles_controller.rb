class Api::V1::Admin::ArticlesController < ApplicationController
  def create
    article = Article.create
    binding.pry
  end
end
