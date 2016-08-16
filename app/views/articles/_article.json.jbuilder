json.(article, :title, :slug, :body, :created_at, :updated_at, :description, :tag_list)
json.author article.user, partial: 'profiles/profile', as: :user
