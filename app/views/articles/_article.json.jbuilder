json.(article, :title, :slug, :body, :created_at, :updated_at, :description, :tag_list)
json.author article.user, partial: 'profiles/profile', as: :user
json.favorited signed_in? ? current_user.favorited?(article) : false
json.favorites_count article.favorites_count || 0
