json.(user, :id, :email, :username, :bio, :image)
json.token user.generate_jwt
