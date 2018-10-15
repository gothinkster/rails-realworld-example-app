# frozen_string_literal: true

json.call(user, :id, :email, :username, :bio, :image)
json.token user.generate_jwt
