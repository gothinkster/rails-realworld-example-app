# frozen_string_literal: true

json.article do |json|
  json.partial! 'articles/article', article: @article
end
