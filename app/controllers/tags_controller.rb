class TagsController < ApplicationController
  def index
    render json: { tags: Article.tag_counts.most_used.map(&:name) }
  end
end
