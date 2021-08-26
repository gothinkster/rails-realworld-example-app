json.(pull_request, :title, :body, :created_at, :updated_at, :description, :tag_list)
json.author pull_request.user, partial: 'profiles/profile', as: :user