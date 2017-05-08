# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_article!

  def create
    current_user.favorite(@article)

    render 'articles/show'
  end

  def destroy
    current_user.unfavorite(@article)

    render 'articles/show'
  end

  private

  def find_article!
    @article = Article.find_by!(slug: params[:article_slug])
  end
end
