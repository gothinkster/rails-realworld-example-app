json.articles do |json|
  json.array! @articles, partial: 'articles/article', as: :article
end

json.articles_count @articles_count
